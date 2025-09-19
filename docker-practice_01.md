1) Запустить в docker приложение (go)
```golang
package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, Docker from Go!\n")
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}

```
2) Запустить в docker приложение (nodejs)
```
const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'application/json'});
  res.end(JSON.stringify({ message: "Hello from Node.js in Docker!" }));
});

server.listen(3000, () => {
  console.log("Server running on port 3000");
});

```
3) Запустить в docker приложение (php)
```php
<?php
echo "Hello from PHP running in Docker!";
?>
```
4) Запустить в docker приложение (java)
- `App.java`
```java
import static spark.Spark.*;

public class App {
    public static void main(String[] args) {
        port(8080);
        get("/", (req, res) -> "Hello from Java + Docker!");
    }
}
```
- `pom.xml`
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>example</groupId>
    <artifactId>docker-java-app</artifactId>
    <version>1.0-SNAPSHOT</version>
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>
    <dependencies>
        <dependency>
            <groupId>com.sparkjava</groupId>
            <artifactId>spark-core</artifactId>
            <version>2.9.4</version>
        </dependency>
    </dependencies>
</project>
```
5) Запустить в docker приложение (C)
```c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>

int main() {
    int sockfd, client;
    struct sockaddr_in srv, cli;
    char buffer[1024];
    sockfd = socket(AF_INET, SOCK_STREAM, 0);

    srv.sin_family = AF_INET;
    srv.sin_port = htons(8080);
    srv.sin_addr.s_addr = INADDR_ANY;

    bind(sockfd, (struct sockaddr *)&srv, sizeof(srv));
    listen(sockfd, 5);

    printf("C server running on port 8080...\n");

    while (1) {
        socklen_t len = sizeof(cli);
        client = accept(sockfd, (struct sockaddr *)&cli, &len);
        read(client, buffer, 1024);
        char response[] = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello from C in Docker!\n";
        write(client, response, strlen(response));
        close(client);
    }
    return 0;
}

```
