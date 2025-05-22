# Use the Bun image as the base image
FROM oven/bun:latest AS builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and bun.lockb (if exists) first for better caching
COPY package.json bun.lockb ./

# Install dependencies
RUN bun install

# Copy the rest of the files
COPY . .

# Build the Astro application
RUN bun run build

# Use a fresh Bun image for the runtime
FROM oven/bun:latest

WORKDIR /app

# Copy only necessary files from the builder stage
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./

# Expose the port Astro runs on (default is 4321)
EXPOSE 4321

# Run the preview server
CMD ["bun", "run", "preview"]