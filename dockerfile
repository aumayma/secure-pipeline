# Use official Nginx Alpine image
FROM nginx:alpine

# Metadata
LABEL maintainer="oumaymaselmi"
LABEL app="static-web-app"
LABEL version="1.0"

# Remove default Nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy static files to Nginx directory
COPY index.html /usr/share/nginx/html/
COPY *.css /usr/share/nginx/html/ 2>/dev/null || true
COPY *.js /usr/share/nginx/html/ 2>/dev/null || true
COPY assets/ /usr/share/nginx/html/assets/ 2>/dev/null || true
COPY *.png /usr/share/nginx/html/ 2>/dev/null || true
COPY *.jpg /usr/share/nginx/html/ 2>/dev/null || true
COPY *.svg /usr/share/nginx/html/ 2>/dev/null || true
COPY *.ico /usr/share/nginx/html/ 2>/dev/null || true

# Set proper permissions
RUN chmod -R 755 /usr/share/nginx/html

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:80 || exit 1

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]