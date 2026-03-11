# Stage 1: Build
FROM node:18 AS build
WORKDIR /app
# Tell Docker to look inside 'bookmyshow-app' for the package files
COPY bookmyshow-app/package*.json ./
RUN npm install
# Tell Docker to copy the source code from 'bookmyshow-app'
COPY bookmyshow-app/ .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
# Copy the build output from the previous stage
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
