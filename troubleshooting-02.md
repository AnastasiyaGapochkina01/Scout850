# Users Manager
## Описание
Простое CRUD (Create, Read, Update, Delete) приложение на языке Go, использующее MariaDB в качестве базы данных. Приложение управляет сущностью "Пользователь" с полями:
- ID (автоинкремент)
- Имя (обязательное)
- Email (обязательное, уникальное)

## Инфраструктура
| Сервер | Public IP | Роль |
| :---: | :---: | :---: |
| compute-vm-1 | 89.169.189.121 | database-server |
| compute-vm-2 | 89.169.189.41 | application-server |

Приложение запущено как systemd-unit `user-manager.service`, слушает порт 8080.

## Использование API
Создать пользователя:
```bash
curl -X POST -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@example.com"}' \
  http://localhost:8080/users
```
Получить всех пользователей
```bash
curl http://localhost:8080/users
```
Получить пользователя по ID
```bash
curl http://localhost:8080/users/1
```
