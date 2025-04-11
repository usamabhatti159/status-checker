FROM node:18-alpine

# Install necessary tools
RUN apk add --no-cache curl

# Create app directory and data directory with proper permissions
WORKDIR /app
RUN mkdir -p /app/data && \
    chown -R node:node /app

# Switch to non-root user
USER node

# Install app dependencies
COPY --chown=node:node package*.json ./
RUN npm ci --legacy-peer-deps

# Bundle app source
COPY --chown=node:node . .

# Build the application
RUN npm run build

# Set environment variables
ENV UPTIME_KUMA_HOST="0.0.0.0"
ENV PORT=3001

# Expose the port
EXPOSE 3001

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3001/ || exit 1

# Set volume for data persistence
VOLUME ["/app/data"]

# Command to run the application
CMD ["node", "server/server.js"]