# Use Nginx as the base image
FROM nginx:latest

# Copy the web app to the container
COPY webapp /usr/share/nginx/html

# Expose port 80
EXPOSE 80
