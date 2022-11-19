FROM node:16 as build-stage
WORKDIR '/usr/src/app'
COPY package*.json .
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx:stable-alpine as production-stage
COPY  ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html
EXPOSE 8081
CMD [ "nginx", "-g", "daemon off;" ]