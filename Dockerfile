FROM node:16 as build-stage
WORKDIR '/usr/src/app'
COPY package*.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx:stable-alpine as production-stage
EXPOSE 80
COPY ./ningx/nginx.conf /etc/nginx/nginx.conf.d/ningx.conf 
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html