FROM node:alpine

ENV NODE_ENV production
ENV PORT 3000


# TODO: add the Docker commands to do these steps:

# at build time:
# set the current directory to /app
WORKDIR /app
# copy the manifest file: package.json
COPY package.json .
# from a shell, run `npm install`
RUN npm install

# copy the content into place
COPY . .
# let traffic flow in on port 3000
EXPOSE 3000

# as the container starts:
# `npm start`
CMD ["npm", "start"]
