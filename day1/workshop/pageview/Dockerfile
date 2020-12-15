FROM node:alpine

WORKDIR /app

COPY pageview.js .
COPY package.json .
COPY package-lock.json .

RUN npm install

EXPOSE 8080

CMD ["node", "pageview.js"]
