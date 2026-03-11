# Stage 1: Build
FROM node:18 AS build

# Set the environment variable here so it applies to all subsequent commands
ENV NODE_OPTIONS=--openssl-legacy-provider

WORKDIR /app
COPY bookmyshow-app/package*.json ./
RUN npm install
COPY bookmyshow-app/ .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
