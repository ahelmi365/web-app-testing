
# # Version 1

# # Stage 1: Build the React app
# FROM node:18.20-alpine AS build



# # Set working directory
# WORKDIR /app

# # Install dependencies
# COPY package*.json ./
# RUN npm ci

# # Set the SERVER_DOMAIN environment variable
# ENV SERVER_DOMAIN=111

# # Add project files and build the React app
# COPY . .
# RUN npm run build

# # Stage 2: Serve the build with Nginx
# FROM nginx:alpine

# # Copy the build output from the previous stage
# COPY --from=build /app/build /usr/share/nginx/html

# COPY nginx.conf /etc/nginx/conf.d/default.conf

# # Optional: Copy the .env file if needed in the container for other purposes
# # COPY .env /etc/nginx/.env

# # Expose environment variables to Nginx (requires using a script to inject them)
# ENV SERVER_DOMAIN 111

# # Expose port 80 for Nginx
# EXPOSE 80

# # Start Nginx
# CMD ["nginx", "-g", "daemon off;"]



# ===== Version 2
# Stage 1: Build the React app
# Stage 1: Build the React app
FROM node:18.20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Serve the build with Nginx
FROM nginx:alpine

# Copy the build output from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Copy the nginx configuration template and the start script
COPY nginx.conf.template /etc/nginx/conf.d/nginx.conf.template

COPY start-nginx.sh /usr/bin/start-nginx.sh

# Make sure the start script is executable
RUN chmod +x /usr/bin/start-nginx.sh

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx using the start script
CMD ["sh", "/usr/bin/start-nginx.sh"]