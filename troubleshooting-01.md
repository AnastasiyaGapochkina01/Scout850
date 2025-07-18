# Инфраструктура
| server_name  | public_ipv4 | OS | role |
| ------------- | ------------- | ------------- | ------------- |
| scout-compute-1  | 62.84.122.213  | Ubuntu 24.04 | database server |
| scout-compute-2  | 89.169.180.122  | Debian 12 | app server |
| scout-compute-3 | 89.169.166.157 | Debian 11 | web server |

# Проект
## MTB & Downhill Blog
Проект представляет собой полнофункциональный блог о горных велосипедах (mountain bike) и даунхилле, реализующий:
- CRUD операции для статей
- Бэкенд на FastAPI (Python)
- Фронтенд на чистом JavaScript/HTML/CSS
- Базу данных PostgreSQL
- Nginx в качестве веб-сервера

### API Endpoints
| Метод| Путь | Описание |
| ------------- | ------------- | ------------- |
| GET	| /api/articles |	Получить все статьи |
| GET	| /api/articles/{id} | Получить статью по ID |
| POST | /api/articles | Создать новую статью |
| PUT | /api/articles/{id} | Обновить статью |
| DELETE | /api/articles/{id} | Удалить статью |

Примеры запросов к API
```bash
curl 127.0.0.1:8000/articles
curl -X GET "http://127.0.0.1:8000/api/articles/1"
curl -X DELETE "http://localhost:8000/api/articles/2"
```
