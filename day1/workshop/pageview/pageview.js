const os = require('os');
const http = require('http');
const redis = require('redis');

const appPort = process.env.APP_PORT;
const redisHost = process.env.REDIS_HOST;
const redisPort = process.env.REDIS_PORT;

const client = redis.createClient({host:redisHost, port: redisPort});

client.on('error', function(error) {
    console.error(error);
});

client.setnx('counter', 0);

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');

  client.get('counter', function(err, result) {
    res.end(`Pageview: ${result} (from hostname: ${os.hostname()})`);
    client.incr('counter');
  });
});

server.listen(appPort, () => {
  console.log(`Server started (port: ${appPort})`);
});
