# Работа с текстом
1) Изучить https://youtu.be/OIFVlMLWLv8
2) В домашней директории создать директорию `text_processing`; в `text_processing` создать файл `application.log` с содержимым
```log
2024-10-31 04:43:12,591 - DEBUG - User logged in
2024-10-31 04:43:12,591 - INFO - Warning: Low memory
2024-10-31 04:43:12,591 - WARNING - Data retrieved successfully
2024-10-31 04:43:12,591 - DEBUG - Critical error: System failure
2024-10-31 04:43:12,591 - ERROR - Application started
2024-10-31 04:43:12,591 - WARNING - Application started
2024-10-31 04:43:12,591 - DEBUG - Warning: Low memory
2024-10-31 04:43:12,591 - INFO - Application started
2024-10-31 04:43:12,592 - ERROR - Application started
2024-10-31 04:43:12,592 - DEBUG - Application started
2024-10-31 04:43:12,592 - WARNING - Critical error: System failure
2024-10-31 04:43:12,592 - ERROR - Critical error: System failure
2024-10-31 04:43:12,592 - DEBUG - Application shutting down
2024-10-31 04:43:12,592 - DEBUG - Application shutting down
2024-10-31 04:43:12,592 - ERROR - Data retrieved successfully
2024-10-31 04:43:12,592 - INFO - Data retrieved successfully
2024-10-31 04:43:12,592 - ERROR - Warning: Low memory
2024-10-31 04:43:12,592 - WARNING - Error: Failed to connect to the database
2024-10-31 04:43:12,592 - INFO - Critical error: System failure
2024-10-31 04:43:12,592 - DEBUG - Request for data received
2024-10-31 04:43:12,592 - INFO - Critical error: System failure
2024-10-31 04:43:12,592 - INFO - Error: Failed to connect to the database
```
3) Найти в файле `application.log`:
- все записи уровня ERROR
- записи о неудачном подключении к базе данных
- все записи уровня WARNING и вывести для них время и сообщение
- все записи, в которых упомнается memory и вывести их уровень
4) В директории `text_processing` создать файл `nginx.log` с содержимым
```log
192.168.1.100 - - [06/Nov/2024:08:30:15 +0300] "GET /index.html HTTP/1.1" 200 1234 "http://example.com" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36"
203.0.113.5 - - [06/Nov/2024:08:30:16 +0300] "POST /api/login HTTP/1.1" 401 173 "-" "PostmanRuntime/7.29.2"
10.0.0.1 - - [06/Nov/2024:08:30:17 +0300] "GET /images/logo.png HTTP/1.1" 304 0 "http://example.com/about" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Safari/605.1.15"
192.168.1.101 - - [06/Nov/2024:08:30:18 +0300] "GET /css/style.css HTTP/1.1" 200 4321 "http://example.com" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Mobile/15E148 Safari/604.1"
203.0.113.10 - - [06/Nov/2024:08:30:19 +0300] "GET /api/users HTTP/1.1" 403 234 "-" "curl/7.68.0"
192.168.1.102 - - [06/Nov/2024:08:30:20 +0300] "GET /blog HTTP/1.1" 301 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36"
10.0.0.2 - - [06/Nov/2024:08:30:21 +0300] "GET /favicon.ico HTTP/1.1" 404 555 "http://example.com" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/119.0"
192.168.1.103 - - [06/Nov/2024:08:30:22 +0300] "POST /contact HTTP/1.1" 200 678 "http://example.com/contact" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36"
203.0.113.15 - - [06/Nov/2024:08:30:23 +0300] "GET /admin HTTP/1.1" 302 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36"
203.0.113.10 - - [06/Nov/2024:10:30:15 +0300] "POST /api/login HTTP/1.1" 401 173 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Mobile/15E148 Safari/604.1"
```
5) Найти в файле `nginx.log`
- запросы на эндпоинт `/api/login`
- все POST запросы и вывести для них код ответа
- все ip-адреса клиентов
6) Из вывода команды `free -h` получить только значение столбца `available`
7) Из файла `/proc/meminfo` получить все строки. относящиеся к HugePages
8) Из вывода команды `env` получить значения SHELL, PWD и USER
9) Выполнить `sudo netstat -tulpn` и отфильтровать вывод по ssh (если netstat не сработал, то использовать `sudo ss -tulpn`)
10) В директории `text_processing` создать файл `hosts` с содержимым
```csv
hostname,interval,timestamp,%user,%system,%memory
sel-srv1,600,2023-10-08 00:00:01 UTC,30.01,20.77,96.21
sel-srv1,600,2023-10-08 00:05:01 UTC,40.07,13.00,84.55
sel-srv1,600,2023-10-08 00:10:01 UTC,5.00,90.55,89.23
sel-srv2,600,2023-10-09 00:15:01 UTC,25.01,15.77,92.21
sel-srv3,600,2023-10-09 00:20:01 UTC,35.07,10.00,80.55
sel-srv3,600,2023-10-09 00:25:01 UTC,10.00,85.55,88.23
sel-srv2,600,2023-10-09 00:30:01 UTC,20.01,25.77,95.21
sel-srv1,600,2023-10-09 00:40:01 UTC,15.00,10.00,87.23
sel-srv2,600,2023-10-09 00:35:01 UTC,45.07,12.00,82.55
sel-srv3,600,2023-10-09 00:40:01 UTC,15.00,80.55,87.23
```
Найти в файле `hosts`
- строки, содержащие `sel-srv2` и вывести для них значение `%memory`
- строки, содержащие дату `2023-10-08`
- строки, у которых значение `%system` равно `10.00` и вывести названия серверов
