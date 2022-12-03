FROM node:16 as build-stage
WORKDIR '/usr/src/app'
COPY package*.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx:stable-alpine as production-stage
EXPOSE 8080
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html