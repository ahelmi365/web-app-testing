#!/bin/sh

# Log the SERVER_DOMAIN environment variable
echo "SERVER_DOMAIN is set to: ${SERVER_DOMAIN}"

# Replace placeholders in the nginx.conf.template with actual environment variables
envsubst '${SERVER_DOMAIN}' < /etc/nginx/conf.d/nginx.conf.template > /etc/nginx/conf.d/default.conf

# Start Nginx
nginx -g 'daemon off;'