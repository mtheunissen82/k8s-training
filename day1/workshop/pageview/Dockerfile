FROM node:slim

WORKDIR /app

COPY pageview.js .
COPY package.json .
COPY package-lock.json .

RUN npm ci && npm cache clean -f

USER node

EXPOSE 8080

CMD ["node", "pageview.js"]
