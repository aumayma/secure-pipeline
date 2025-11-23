# Use official Nginx Alpine image
FROM nginx:alpine

# Metadata
LABEL maintainer="oumaymaselmi"
LABEL app="static-web-app"
LABEL version="1.0"

# Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy all project files to nginx directory
COPY . /usr/share/nginx/html/

# Remove non-web files from nginx directory
RUN cd /usr/share/nginx/html && \
    rm -rf .git .github .gitignore dockerfile Dockerfile README.md *.md .dockerignore || true && \
    chmod -R 755 /usr/share/nginx/html && \
    chown -R nginx:nginx /usr/share/nginx/html

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:80 || exit 1

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]