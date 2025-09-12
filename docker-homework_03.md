1) Запустить в docker приложение
```python
from flask import Flask, jsonify
import random
import uuid

app = Flask(__name__)


@app.route("/")
def main_page():
    return "Main Flask Page"


@app.route("/about")
def about():
    data = {
        "company": "DevOps Systems",
        "location": "Moscow",
        "admin": "admin@example.com"
    }
    return jsonify(data)


@app.route("/task")
def task():
    statuses = ["shipping", "created", "done"]
    task_data = {
        "id": f"DVPS-{uuid.uuid4().hex[:8]}",
        "status": random.choice(statuses)
    }
    return jsonify(task_data)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

```
в requirements.txt будет только flask

2) запустить в docker приложение 
```golang
package main

import (
	"encoding/json"
	"log"
	"math/rand"
	"net/http"
	"time"
)

type Book struct {
	ID      int    `json:"id"`
	Title   string `json:"title"`
	Author  string `json:"author"`
	Publish int    `json:"publish"`
}

var books = []Book{
	{Title: "1984", Author: "George Orwell", Publish: 1949},
	{Title: "The Catcher in the Rye", Author: "J.D. Salinger", Publish: 1951},
	{Title: "To Kill a Mockingbird", Author: "Harper Lee", Publish: 1960},
	{Title: "The Great Gatsby", Author: "F. Scott Fitzgerald", Publish: 1925},
	{Title: "Moby Dick", Author: "Herman Melville", Publish: 1851},
}

func booksHandler(w http.ResponseWriter, r *http.Request) {
	count := rand.Intn(len(books)) + 1
	responseBooks := make([]Book, count)
	for i := 0; i < count; i++ {
		b := books[rand.Intn(len(books))]
		b.ID = i + 1
		responseBooks[i] = b
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(responseBooks)
}

func main() {
	rand.Seed(time.Now().UnixNano())
	http.HandleFunc("/books", booksHandler)
	log.Println("Server started on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
```
3) запустить в docker приложение
```php
<?php

$hour = (int) date('H');
if ($hour < 6) {
    $greeting = "Доброй ночи!";
} elseif ($hour < 12) {
    $greeting = "Доброе утро!";
} elseif ($hour < 18) {
    $greeting = "Добрый день!";
} else {
    $greeting = "Добрый вечер!";
}

$randomColor = sprintf('#%06X', mt_rand(0, 0xFFFFFF));
?>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Динамический сайт на PHP</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
            background-color: #f0f0f0;
        }
        .container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 0 auto;
            width: 80%;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .color-block {
            width: 100px;
            height: 100px;
            margin: 20px auto;
            border: 1px solid #ddd;
        }
        .server-info {
            margin-top: 30px;
            font-size: 0.9em;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><?php echo $greeting; ?></h1>
        <p>Сейчас на сервере: <?php echo date('d.m.Y H:i:s'); ?></p>

        <div class="color-block" style="background-color: <?php echo $randomColor; ?>;"></div>
        <p>Новый цвет при каждом обновлении страницы</p>

        <h2>Системная информация</h2>
        <p>Версия PHP: <?php echo phpversion(); ?></p>
        <p>ОС сервера: <?php echo php_uname('s'); ?></p>

        <h2>Форма обратной связи</h2>
        <form method="POST">
            Имя: <input type="text" name="name" required><br><br>
            Email: <input type="email" name="email" required><br><br>
            <input type="submit" value="Отправить">
        </form>

        <?php
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            echo '<div class="server-info">';
            echo '<h3>Данные получены сервером:</h3>';
            echo 'Имя: ' . htmlspecialchars($_POST['name']) . '<br>';
            echo 'Email: ' . htmlspecialchars($_POST['email']);
            echo '</div>';
        }
        ?>

        <div class="server-info">
            <p>Сервер: <?php echo $_SERVER['SERVER_SOFTWARE']; ?></p>
            <p>Запрос обработан за: <?php echo round(microtime(true) - $_SERVER["REQUEST_TIME_FLOAT"], 3); ?> секунд</p>
        </div>
    </div>
</body>
</html>
```
