##### Спроектировать БД для онлайн-кинотеатра
Требования к данным:
1) Хранить информацию о фильмах (название, год выпуска, рейтинг).
2) Учитывать пользователей (имя, email, дата регистрации).
3) Фиксировать факты просмотра фильмов пользователями (кто, что и когда смотрел).
4) Каждый фильм относится к одному жанру (для упрощения).

##### Таблицы (5 штук):
1) users - Пользователи
- user_id (INT, PK)
- name (VARCHAR(50), NOT NULL
- email (VARCHAR(100), UNIQUE
- registration_date (DATE), NOT NULL
2) movies - Фильмы
- movie_id (INT, PK)
- title (VARCHAR(100), NOT NULL
- release_year (INT), NOT NULL
- rating (DECIMAL(3,1)) - рейтинг IMDb от 0 до 10
3) genres - Жанры
- genre_id (INT, PK)
- name (VARCHAR(30) - например, "Комедия", "Фантастика"
- movie_genres
- movie_id (INT, FK → movies)
- genre_id (INT, FK → genres)
4) views - Просмотры
- view_id (INT, PK)
- user_id (INT, FK → users), NOT NULL
- movie_id (INT, FK → movies), NOT NULL
- view_date (DATETIME), NOT NULL
