# Muti-stage Dockerfile

# stage name is builder
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Second stage (the run stage)
FROM nginx
# Copy the build folder from the previous stage (whose name is "builder") to nginx container's folder /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
# We don't have to put any RUN command here because the nginx container by default is going to start nginx for us!