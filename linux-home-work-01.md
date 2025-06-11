# Часть 1: работа с процессами
1) В списке процессов найти процесс bash и вывести для него поля id, user и comm
2) В домашней директории создать файл web_server с содержимым
```
#!/bin/bash
LOG_FILE="$HOME/web_server.log"
log_levels=("ERROR" "INFO" "WARNING" "DEBUG")
methods=("GET" "POST" "PUT" "PATCH" "OPTIONS" "DELETE")
echo "Starting web-server on $(hostname)" >> $LOG_FILE
while true
do
  sleep 5
  random_method=${methods[$RANDOM % ${#methods[@]}]}
  random_level=${log_levels[$RANDOM % ${#log_levels[@]}]}
  echo "$(date +"%Y-%d-%m [%H:%M:%S]") $random_level $random_method" >> $LOG_FILE
  sleep 5
done
```
- Сделать файл web_server исполняемым для всех и запустить его в фоновом режиме;
- Найти id процесса web_server;
- В домашней директории найти файл web_server.log и посмотреть его содержимое
- В директории /proc найти каталог, который соответствует найденному выше id процесса web_server;
- Поставить процесс на паузу, проверить его статус и возобновить процесс
- Убить процесс web_server
# Часть 2: работа с systemd
## Разминка
1) Установить nginx, если он еще не установлен
2) Посмотреть статус демона nginx
3) Остановить nginx
4) Запустить nginx
5) Убрать nginx из автозагрузки
6) Вернуть nginx в автозагрузку
7) "Замаскировать" nginx, попробовать перезапустить/остановить/запустить nginx; снять с nginx "маскировку"
## Написание unit-файлов
1) Установить на ВМ php
2) В директории /opt создать папку rot13
3) В директории /opt/rot13 создать файл с именем rot13-server.php с кодом
```
<?php
$sock = socket_create(AF_INET, SOCK_DGRAM, SOL_UDP);
socket_bind($sock, '0.0.0.0', 10000);
for (;;) {
  socket_recvfrom($sock, $message, 1024, 0, $ip, $port);
  $reply = str_rot13($message);
  socket_sendto($sock, $reply, strlen($reply), 0, $ip, $port);
}
```
4) Запустить сервер командой php rot13-server.php и проверить что сервер работает: выполнить nc -u 127.0.0.1 10000 и ввести Hello World
5) Написать юнит-файл для запуска rot13-server.php как сервиса
## Написание сложных unit-файлов
1) Установить redis ([install-redis-on-linux](https://redis.io/docs/latest/operate/oss_and_stack/install/install-redis/install-redis-on-linux/)) - ссылка доступна под VPN
2) Посмотреть статус демона redis
3) Запустить второй экземпляр демона redis, написав systemd unit
