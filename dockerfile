FROM nginx:alpine

# Metadata
LABEL maintainer="oumaymaselmi"
LABEL app="static-web-app"

# Copy static files
COPY index.html /usr/share/nginx/html/
COPY *.css /usr/share/nginx/html/
COPY *.js /usr/share/nginx/html/
COPY *.png /usr/share/nginx/html/ 2>/dev/null || true
COPY *.jpg /usr/share/nginx/html/ 2>/dev/null || true

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:80 || exit 1

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

---

## 🔧 **ÉTAPE 6 : Configuration GitHub Secrets**

**Settings → Secrets and variables → Actions → New repository secret**

1. **JENKINS_TRIGGER_URL**
```
   https://xxxx.ngrok-free.app/generic-webhook-trigger/invoke?token=static-app-webhook-token
```

2. **JENKINS_API_TOKEN**
```
   (Token généré dans Jenkins User → Configure → API Token)