# Use an official Node.js runtime as a parent image
# Using Node.js v22 as requested by the user
FROM node:22-alpine AS development

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (using npm as requested)
COPY package*.json ./

# Install app dependencies using npm ci for potentially faster and more reliable builds
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the NestJS application for production
# Assumes a standard NestJS build script 'build' exists in package.json
RUN npm run build

# Start a new stage for production to keep the image size small
FROM node:22-alpine AS production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

# Copy package.json and package-lock.json again
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Copy the built application from the development stage
COPY --from=development /usr/src/app/dist ./dist

# Expose the port the app runs on (default NestJS port is 3000)
EXPOSE 3000

# Define the command to run the application
# Assumes the main entry point after build is dist/main.js
CMD ["node", "dist/main"]
