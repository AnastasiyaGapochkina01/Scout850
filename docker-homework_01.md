1) Запустить контейнер nginx так, чтобы по запросу с хоста на 127.0.0.1:8082 отдавалась страничка https://gist.github.com/AnastasiyaGapochkina01/601c541acc52c21556d45d597613535d
<img width="1440" height="789" alt="image" src="https://github.com/user-attachments/assets/4f1cb44f-b82d-41b9-a087-363321928745" />

2) Запустить контейнер с postgresql; при создании контейнера должны создаться
- пользователь tracker с паролем 1212tracker
- база данных orders

3) Написать Dockerfile, собрать image и запустить контейнер для приложения https://github.com/hackersandslackers/golang-helloworld
4) Написать Dockerfile, собрать image и запустить контейнер для приложения https://github.com/AnastasiyaGapochkina01/node-app
5) Написать Dockerfile для собственной версии nginx
- удалить конфиг по умолчанию (default)
- создать конфиг файл для статического сайта, расположенного в /var/www/landing
- создать директорию /var/www/landing; положить туда файл из задания №1
- установить: vim, iputils-ping, iproute2, dnsutils
- установить таймзону Europe/Moscow

собрать image, запустить из него контейнер и проверить что landing отдается

6) Написать Dockerfile, собрать image и запустить контейнер для приложения https://gist.github.com/AnastasiyaGapochkina01/ad0827f3b7a3aca7ab927ddb15b25e37

Приложению требуется БД postgres, а так же переменные окружения. Compose для запуска НЕ использовать. Примеры запросов для проверки
```bash
curl -X POST "http://localhost:8000/items" \
-H "Content-Type: application/json" \
-d '{"name": "Test item"}'

curl -X GET "http://localhost:8000/items"
```

