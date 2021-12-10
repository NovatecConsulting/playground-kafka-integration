FROM node:16-alpine as build
MAINTAINER code@uweeisele.eu

WORKDIR /usr/src

COPY package*.json ./
RUN npm install

COPY tsconfig.json ./
COPY src/ ./
RUN npm run compile

FROM node:16-alpine
MAINTAINER code@uweeisele.eu

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci --only=production

COPY --from=build /usr/src/out ./

USER nobody 

EXPOSE 3000
CMD [ "node", "server.js" ]