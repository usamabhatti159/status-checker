# Use Node.js 20.4 as per Uptime Kuma requirements
FROM node:20.4

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Build the app (not needed for Uptime Kuma, it runs directly)
# RUN npm run build (commented out as Uptime Kuma doesn't require this)

# Expose port 3001 (Uptime Kuma default)
EXPOSE 3001

# Start the server
CMD ["node", "server/server.js"]