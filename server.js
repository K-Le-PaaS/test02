const http = require('http');

const PORT = process.env.PORT || 8080;

const server = http.createServer((_, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain; charset=utf-8');
  res.end('ok\n');
});

server.listen(PORT, () => {
  // 플랫폼이 PORT를 주입하므로 별도 로그만 남김
  console.log(`server listening on ${PORT}`);
});
