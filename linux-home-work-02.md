Запустить с помощью systemd юнита Node.js приложение, которое запускает HTTP-сервер, логирует запросы и предоставляет базовый API:
```
const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 3000;
const LOG_FILE = path.join(__dirname, 'app.log');

function log(message) {
  const timestamp = new Date().toISOString();
  const logMessage = `[${timestamp}] ${message}\n`;
  
  fs.appendFile(LOG_FILE, logMessage, (err) => {
    if (err) console.error(`Log error: ${err}`);
  });
  
  console.log(logMessage.trim());
}

const server = http.createServer((req, res) => {
  log(`${req.method} ${req.url}`);
  
  if (req.url === '/health') {
    res.writeHead(200);
    return res.end('OK');
  }
  
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello from Systemd Service!\n');
});

server.listen(PORT, () => {
  log(`Server running on port ${PORT}`);
  log(`PID: ${process.pid}`);
});

process.on('SIGTERM', () => {
  log('Received SIGTERM. Shutting down...');
  server.close(() => process.exit(0));
});

process.on('SIGINT', () => {
  log('Received SIGINT. Shutting down...');
  server.close(() => process.exit(0));
});
```
##### Требования к окружению и запуск:
- установлен nodejs
- в системе добавлен пользователь nodeuser
- в директории /opt создана папка node-app с владельцем и группой владельцев nodeuser
- в директории /opt/node-app создан файл server.js с кодом приложения
- запуск осуществляется командой `node server.js`

##### Проверка
```
anestesia@compute-vm-2-2-15-hdd-1749614591492:~$ curl http://localhost:3000
Hello from Systemd Service!
anestesia@compute-vm-2-2-15-hdd-1749614591492:~$ curl http://localhost:3000
Hello from Systemd Service!

anestesia@compute-vm-2-2-15-hdd-1749614591492:~/node-app$ tail -f app.log
[2025-06-15T09:53:40.840Z] Server running on port 3000
[2025-06-15T09:53:40.843Z] PID: 28023
[2025-06-15T09:53:57.726Z] GET /health
[2025-06-15T09:56:17.517Z] PID: 28056
[2025-06-15T09:56:17.514Z] Server running on port 3000
[2025-06-15T09:56:19.196Z] GET /
...
```
