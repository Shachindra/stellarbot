# Use Node.js 23 as the base image
FROM node:23-alpine

# Install system dependencies
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    git \
    sqlite

# Create app directory
WORKDIR /app

# Install pnpm globally
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install pm2 globally for service management
RUN pnpm add -g pm2

# Install dependencies
RUN pnpm install

# Copy source code
COPY . .

# Build the application
RUN pnpm run build

# Expose any necessary ports (add specific ports if needed)
# EXPOSE 3000

# Set the default command
CMD ["pnpm", "start"]

# Alternative command for running all services with pm2
# CMD ["pnpm", "run", "start:service:all"]