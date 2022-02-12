ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}
RUN apt-get update -qq && apt-get install -y apache2-utils
# Configs
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /etc/nginx/html/index.html
# Entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint" ]