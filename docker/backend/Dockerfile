# Neurite Backend Dockerfile
# Multi-stage build for optimized production image

# Stage 1: Build stage
FROM node:18-alpine AS builder

# Install system dependencies for Playwright
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    && rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /app

# Copy package files for main servers
COPY localhost_servers/package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy server source code
COPY localhost_servers/ ./

# Stage 2: Production stage
FROM node:18-alpine AS production

# Install system dependencies for Playwright
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    curl \
    && rm -rf /var/cache/apk/*

# Create app user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S neurite -u 1001

# Set working directory
WORKDIR /app

# Copy built application from builder stage
COPY --from=builder /app /app

# Create data directory for SQLite database
RUN mkdir -p /app/data && \
    chown -R neurite:nodejs /app

# Set environment variables
ENV NODE_ENV=production
ENV PORT=7070
ENV PLAYWRIGHT_BROWSERS_PATH=/usr/bin
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Create startup script
RUN cat > /app/start.sh << 'EOF'
#!/bin/sh

echo "Starting Neurite Backend Services..."

# Set up Playwright
export PLAYWRIGHT_BROWSERS_PATH=/usr/bin
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Start the servers
exec node start_servers.js
EOF

RUN chmod +x /app/start.sh

# Switch to non-root user
USER neurite

# Expose port
EXPOSE 7070

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:7070/check || exit 1

# Start the application
CMD ["/app/start.sh"]
