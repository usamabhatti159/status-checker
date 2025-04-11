FROM node:18-alpine

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm ci --legacy-peer-deps

# Bundle app source
COPY . .

# Build the application
RUN npm run build

# Set environment variables for binding to all interfaces
ENV UPTIME_KUMA_HOST="0.0.0.0"

# Expose the port the app runs on
EXPOSE 3001

# Set volume for data persistence
VOLUME ["/app/data"]

# Command to run the application
CMD ["node", "server/server.js"]