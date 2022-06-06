# Defines what will be invoked whenever make is run without arguments
.DEFAULT_GOAL := up

# Ditto version (small / full)
# small - our custom packed version
# full  - upstream version
DITTO_VERSION := small

# Modules
# each module corresponds to a .yml file in the project root directory
modules_all := \
 	chassis-routers \
	net-ovs \
	chassis-bind9 \
	chassis-ditto-database \
	chassis-ditto-register \
	chassis-ditto-$(DITTO_VERSION) \
	chassis-docker-api-proxy \
	chassis-scada \
	chassis-workflows-viewer \
	performance-sample \
	savona-ditto-customization \
	savona-operator \
	savona-scada-customization \
	savona-sensors \
	savona-website \
	savona-workflows-viewer-customization \
	savona-cabinet-biblioteca \
	savona-cabinet-delfino \
	savona-cabinet-lagorio \
	savona-cabinet-locatelli \
	savona-cabinet-marchi \
	savona-cabinet-seb \
	chassis-vpn 

# Which modules are to be instantiated
modules := \
	$(modules_all)

# Allow to act on a single service by specifying make service=<service_name> <target>
ifneq ($(service),)
	services = $(service)
endif

# Wrapper around Docker compose
define docker_compose
	docker-compose $(foreach module,$(modules),-f $(module).yml) $(1) $(services)
endef

#
# Framework commands
#

# Build all container images
build:
	$(call docker_compose,$@)
	docker-compose -f dovesnap/dovesnap.yml build

# Start the Dovesnap network plugin
dovesnap-up:
	$(eval p=$(shell docker ps | grep -P '(?=.*dovesnap)(?=.*plugin)' >/dev/null 2>&1 && echo t || echo f))
	@if [ "$(p)" = "t" ]; then\
        echo "dovesnap plugin running";\
	else\
		cd dovesnap; docker-compose -f dovesnap.yml up -d;\
    fi

# Stop the Dovesnap network plugin
dovesnap-down:
	cd dovesnap; docker-compose -f dovesnap.yml down

# Run the framwork
up: sysctls dovesnap-up
	$(call docker_compose,$@ --remove-orphans)

# Run the framwork, in background
upd: sysctls dovesnap-up
	$(call docker_compose,up --detach)

# Stop the framework
down: 
	$(call docker_compose,$@ --remove-orphans)

# Stop the framework and the network plugin
downall: down dovesnap-down

# Stop the framework and remove all containers, volumes, and networks
rm: 
	$(call docker_compose,$@ --force --stop -v)
	docker volume prune --force
	docker network prune --force

# Show logs of a service
logs: sysctls
	$(call docker_compose,$@)

# Show tailing logs of a service
logsf: sysctls
	$(call docker_compose,logs -f --tail=500)

# Push images
push:
	$(call docker_compose,$@)
	docker-compose -f dovesnap/dovesnap.yml push

# Tweak OS settings
sysctls:
	$(eval f=$(shell /sbin/sysctl fs.inotify.max_user_instances | cut -d= -f 2 | tr -d '[:space:]'))
	@if [ "$(f)" != "262144" ]; then\
		sudo sysctl -w fs.inotify.max_user_instances=262144;\
	fi


#
# Useful commands
#

# Set the date to the one used for the experiments in the paper
set-date: rm
	sudo timedatectl set-ntp false
	sudo vmware-toolbox-cmd timesync disable || true
	sudo timedatectl set-timezone "UTC"
	sudo date -s "11 APR 2021 23:30:00"
	rm -f config/chassis-vpn/ca.cert
	rm -f config/chassis-vpn/ca.key

# Reset the original date
reset-date:
	sudo timedatectl set-ntp true
	sudo vmware-toolbox-cmd timesync enable || true

# Perform export of the SCADA datapoints
scada-db-export:
	cd scada-export; python3 app.py
