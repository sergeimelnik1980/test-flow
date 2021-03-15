FROM node AS build

WORKDIR /home/test

COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json

RUN npm ci

COPY ./ ./

RUN npm run build


FROM nginx
COPY ./nginx-conf/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /home/test/dist /home/test/dist
 
