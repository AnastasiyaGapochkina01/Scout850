1) Создать БД (mysql/postgres) `surf_shop`, в ней
- добавить таблицы
  - `categories` с атрибутами
    - category_id
    - title
    - description
  - `products` с атрибутами
    - product_id
    - title
    - description
    - category_id
    - price
    - stock (остатки)
  - `customers` с атрибутами
    - customer_id 
    - username
    - fullname
    - email
    - phone
  - `orders` с атрибутами
    - order_id
    - customer_id
    - order_date
    - status
    - total_amount
  - `order_items` с атрибутами
    - id
    - order_id
    - product_id
    - quantity
    - price

Связи:
- products.category_id → categories.category_id
- orders.customer_id → customer_id
- order_items.order_id → orders.order_id
- order_items.product_id → products.product_id
2) Добавить данные в таблицы (5-10 записей)
3) Написать скрипт для резервного копирования БД с помощью внешних инструментов
- если используете postgres, то barman/pgBackRest
- если используете mariadb/mysql/percona, то Mariabackup/Percona XtraBackup\
Обязательно добавьте в скрипт опцию по восстановлению БД из бэкапа. Пример запуска
```bash
# создание бэкапа
./run_bkp.sh create
# восстановление
./run_bkp.sh restore
```
4) Настроить репликацию master → slave для БД
5) Написать скрипт для автоматического failover БД. Скрипт
- проверяет доступность master через nc -z master 5432. При недоступности:
  - останавливает репликацию на slave
  - промоутит реплику в основную БД
