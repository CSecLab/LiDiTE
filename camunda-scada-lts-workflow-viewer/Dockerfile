FROM openresty/openresty:1.19.3.1-6-buster-fat
RUN opm get pintsized/lua-resty-http
RUN apt-get update -qq && apt-get install -y findutils
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

RUN mkdir -p /usr/local/nginx/lua
COPY lua/ /usr/local/nginx/lua/

RUN mkdir -p /srv
ADD webcontent/ /srv
