const os = require('os');
const http = require('http');

const port = 8080;

let counter = 0;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end(`Pageview: ${counter} (from hostname: ${os.hostname()})`);

  counter++;
});

server.listen(port, () => {
  console.log(`Server started (port: ${port})`);
});
