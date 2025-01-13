
# 10x Compacted Master Class for Dockerfile

## 1. Minimal Base Image
- Start with an official lightweight image (e.g., alpine, python:3-alpine) to reduce size and security surface area.  
- Example:  
```dockerfile
FROM alpine:3.18
```

## 2. Environment Configuration
- Use ENV to set default variables for easier updates and configuration.  
```dockerfile
ENV APP_HOME=/usr/src/app
```
- Keep environment details near the top of the Dockerfile for quick visibility.

## 3. Multi-Stage Build
- Split your Dockerfile into stages for building dependencies and packaging the final image.  
- Reduces image size and speeds up builds by discarding unneeded artifacts.  
```dockerfile
# Stage 1: Build
FROM golang:1.20-alpine AS builder
WORKDIR /build
COPY . .
RUN go build -o myapp

# Stage 2: Runtime
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /build/myapp .
CMD ["./myapp"]
```

## 4. Layer Maximization via Caching
- Combine commands that change less frequently (e.g., package installs) and separate frequently changed layers (e.g., code copies) to leverage Docker caching effectively.  
```dockerfile
RUN apk update && \
    apk add --no-cache curl tzdata # Single RUN for dependencies
```

## 5. Order Matters
- Place the most static steps first (dependencies, environment) and the most dynamic steps last (COPY, commands).  
- Minimizes rebuild time when code changes.

## 6. Leverage .dockerignore
- Exclude files and folders not required for your final build (e.g., logs, node_modules if already installed in an earlier stage).  
- Helps reduce the build context for faster, smaller images.

## 7. Security Hardening
- Remove unnecessary packages and privileged instructions (e.g., root-based operations).  
```dockerfile
RUN adduser -D myuser
USER myuser
```
- Ensure your container runs as a non-root user where possible.

## 8. Explicit Ports and Health Checks
- Declare your exposed ports for clarity (even if not strictly required by newer Docker versions).  
- Use HEALTHCHECK to monitor the container’s health.  
```dockerfile
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:8080/health || exit 1
```

## 9. CMD vs. ENTRYPOINT
- Use ENTRYPOINT for the main container process and CMD for default arguments or commonly changed options.  
- Example:  
```dockerfile
ENTRYPOINT ["./myapp"]
CMD ["--help"]
```

## 10. Final Example (Shortened)
Below is a stripped-down example showcasing many of these practices in action:

```dockerfile
# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /build
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Runtime
FROM nginx:alpine
ENV APP_HOME=/usr/share/nginx/html
WORKDIR $APP_HOME
COPY --from=builder /build/dist $APP_HOME
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -f http://localhost:80 || exit 1
CMD ["nginx", "-g", "daemon off;"]
```

