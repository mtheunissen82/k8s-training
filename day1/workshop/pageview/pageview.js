const os = require('os');
const http = require('http');
const redis = require('redis');

const port = 8080;

const redisHost = 'redis';
const redisPort = 6379;

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

server.listen(port, () => {
  console.log(`Server started (port: ${port})`);
});
