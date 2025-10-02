# Neurite Frontend Dockerfile
# Multi-stage build for optimized production image

# Stage 1: Build stage
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./
COPY vite.config.js ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Production stage
FROM nginx:alpine AS production

# Install Node.js for potential server-side rendering
RUN apk add --no-cache nodejs npm

# Copy built application from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy Vite config for development mode
COPY --from=builder /app/vite.config.js /app/
COPY --from=builder /app/package*.json /app/

# Install Vite for development server
WORKDIR /app
RUN npm install vite --save-dev

# Copy source code for development
COPY --from=builder /app/js /app/js
COPY --from=builder /app/resources /app/resources
COPY --from=builder /app/wiki /app/wiki
COPY --from=builder /app/index.html /app/

# Create nginx configuration
RUN cat > /etc/nginx/conf.d/default.conf << 'EOF'
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    # Gzip compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    # Handle client-side routing
    location / {
        try_files $uri $uri/ /index.html;
    }

    # API proxy to backend
    location /api/ {
        proxy_pass http://neurite-backend:7070/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Static files caching
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
EOF

# Create startup script
RUN cat > /app/start.sh << 'EOF'
#!/bin/sh

# Check if we should run in development mode
if [ "$NODE_ENV" = "development" ]; then
    echo "Starting development server..."
    cd /app
    npm run start:host
else
    echo "Starting production server..."
    nginx -g "daemon off;"
fi
EOF

RUN chmod +x /app/start.sh

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start the application
CMD ["/app/start.sh"]
