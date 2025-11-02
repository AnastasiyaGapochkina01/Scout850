> [!TIP]
> Подсказка: чтобы получить список доменов и конфига можно его грепнуть по `server_name`

Написать скрипт, который проверяет в какие ip адреса резолвятся доменные имена, которые обслуживает nginx с таким конфигурационным файлом
```
http {
    sendfile on;
    tcp_nopush on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    server {
        listen 80;
        server_name vault.anestesia.fun;
        root /var/www/domain1;
        index index.html index.htm index.php;

        location / {
            try_files $uri $uri/ =404;
        }

        location ~ \.php$ {
            include fastcgi_params;
            fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
    }

    server {
        listen 80;
        server_name k8s-app.anestesia.fun;

        location / {
            proxy_pass http://localhost:8080;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }

    server {
        listen 80;
        server_name k8s.dos-29.anestesia.fun;
        return 301 https://$host$request_uri;
    }
    server {
        listen 443 ssl;
        server_name k8s.dos-29.anestesia.fun;

        ssl_certificate /etc/ssl/certs/domain3.crt;
        ssl_certificate_key /etc/ssl/private/domain3.key;

        root /var/www/domain3;
        index index.html;

        location / {
            try_files $uri $uri/ =404;
        }
    }

    server {
        listen 80;
        server_name diary.anestesia.fun;
        root /var/www/domain4;
        index index.html;

        location / {
            try_files $uri $uri/ =404;
            expires 30d;
            add_header Cache-Control "public";
        }
    }

    server {
        listen 80;
        server_name metrics.anestesia.fun;
        root /var/www/domain5;
        index index.html;

        location / {
            auth_basic "Restricted Area";
            auth_basic_user_file /etc/nginx/.htpasswd;
            try_files $uri $uri/ =404;
        }
    }
}

```
