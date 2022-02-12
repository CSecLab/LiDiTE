# docker-api-proxy

In order for the Camunda people scaling workflow to work, Docker API access is required.

Such access requires modifying the daemon's configuration file and restarting the service.

To lift this prerequisite this container exposes the same API that Docker would expose by forwarding TCP requests to the Docker socket available at `/var/run/docker.sock` (that should be mounted inside of this container).

Source based filtering is available by specifying the allowed source address in CIDR format inside of the `ACCEPT_RANGE` environment variable.
