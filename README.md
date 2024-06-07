# urgentNews
The application, named urgentNews, is a web-based one-page platform that displays the ten most recent urgent news articles, each featuring a title and its corresponding content. The app will run on three containers. Each container runs one of the following images:
1. One image is responsible for running the MySQL database and setting up a table called "News". Additionally, it inserts ten articles into the database.
2. Another image contains the backend service, which includes an API named "getUrgentNews". This API retrieves the news articles from the database and returns them.
3. Lastly, there is an image for the front-end service, which sets up an Apache server that hosts the front-end webpage

## Docker Setup

### Backend Dockerfile
```
Copy code
FROM python:3.9-slim

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

ENV FLASK_APP=app.py

CMD ["flask", "run", "--host=0.0.0.0"]
```

Explanation:
- FROM python:3.9-slim: Uses a slim version of Python 3.9 as the base image to keep the image lightweight.
- WORKDIR /app: Sets the working directory to /app inside the container.
- COPY . /app: Copies all the files from the current directory on the host machine to the /app directory in the container.
- RUN pip install --no-cache-dir -r requirements.txt: Installs the required Python packages listed in requirements.txt without caching to reduce image size.
- EXPOSE 5000: Exposes port 5000, which is the default port Flask runs on.
- ENV FLASK_APP=app.py: Sets an environment variable to specify the Flask application entry point.
- CMD ["flask", "run", "--host=0.0.0.0"]: Runs the Flask application and makes it accessible on all network interfaces.


#### To build Backend image run the following command:

```
cd Backend
docker build -t urgent_news _backend.
```

## MySQL Database Dockerfile

```
Copy code
FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=urgentNews

COPY news.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
```

Explanation:
- FROM mysql: Uses the latest version of the official MySQL image as the base image.
- ENV MYSQL_ROOT_PASSWORD=rootpassword: Sets the root password for the MySQL server.
- ENV MYSQL_DATABASE=urgentNews: Creates a database named urgentNews.
- COPY news.sql /docker-entrypoint-initdb.d/: Copies the news.sql file to the initialization directory. This file will be executed to set up the initial database schema and data when the container starts.
- XPOSE 3306: Exposes port 3306, which is the default port for MySQL.

#### To build Database image run the following command:
```
cd Database
docker build -t urgent_news_db .
```


## Frontend Dockerfile

```
FROM php:7.4-apache

COPY . /var/www/html

EXPOSE 80
```

Explanation:
- FROM php:7.4-apache: Uses the official PHP 7.4 image with Apache as the base image.
- COPY . /var/www/html: Copies all the files from the current directory on the host machine to the /var/www/html directory in the container, which is the default directory served by Apache.
- EXPOSE 80: Exposes port 80, which is the default port for HTTP.

#### To build Database image run the following command:

```
cd Frontend
docker build -t urgent_news .
```


## Docker Compose Dockerfile
```
version: '3.8'

services:
  db:
    image: mysql:latest
    container_name: urgent_news_db_container
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: urgentNews
    volumes:
      - ./Database/news.sql:/docker-entrypoint-initdb.d/news.sql
    ports:
      - "3306:3306"
    networks:
      - urgent_news_network

  backend:
    build:
      context: ./Backend
    container_name: urgent_news_backend_container
    environment:
      DB_HOST: db
      DB_USER: root
      DB_PASSWORD: rootpassword
      DB_NAME: urgentNews
    ports:
      - "5000:5000"
    depends_on:
      - db
    networks:
      - urgent_news_network

  frontend:
    build:
      context: ./Frontend
    container_name: urgent_news_frontend_container
    ports:
      - "8080:80"
    depends_on:
      - backend
    networks:
      - urgent_news_network

networks:
  urgent_news_network:
    driver: bridge
```

Explanation:

1. Version
Specifies the version of the Docker Compose file format. Version 3.8 is a commonly used version that provides a balance of features and stability.

2. Database Service
- image: mysql : Uses the latest version of the MySQL image from Docker Hub.
- container_name: urgent_news_db_container: Names the container urgent_news_db_container for easier reference.
- environment: Sets environment variables for MySQL configuration.
- MYSQL_ROOT_PASSWORD: Sets the root password for MySQL to rootpassword.
- MYSQL_DATABASE: Creates a database named urgentNews.
- volumes: Mounts a volume to initialize the database.
- ./Database/news.sql:/docker-entrypoint-initdb.d/news.sql: Copies the news.sql file from the host to the initialization directory in the container.
- ports: Maps port 3306 on the host to port 3306 in the container, making the MySQL service accessible.
- networks: Connects this service to the urgent_news_network network.

3. Backend Service
- build: Builds the image from the Dockerfile located in the ./Backend directory.
- container_name: urgent_news_backend_container: Names the container urgent_news_backend_container.
- environment: Sets environment variables for the backend service to connect to the database.
- DB_HOST: The hostname for the database, set to db (service name of the database container).
- DB_USER: The database user, set to root.
- DB_PASSWORD: The database password, set to rootpassword.
- DB_NAME: The name of the database to use, set to urgentNews.
- ports: Maps port 5000 on the host to port 5000 in the container, making the backend service accessible.
- depends_on: Specifies that the backend service depends on the database service, ensuring that the database service starts first.
- networks: Connects this service to the urgent_news_network network.

4. Frontend Service
- build: Builds the image from the Dockerfile located in the ./Frontend directory.
- container_name: urgent_news_frontend_container: Names the container urgent_news_frontend_container.
- ports: Maps port 8080 on the host to port 80 in the container, making the frontend service accessible.
- depends_on: Specifies that the frontend service depends on the backend service, ensuring that the backend service starts first.
- networks: Connects this service to the urgent_news_network network.

5. Networks
- urgent_news_network: Defines a custom network named urgent_news_network.
- driver: bridge: Specifies the network driver to use. The bridge driver creates a private internal network on the host, allowing the containers to communicate with each other.



## Pushing Images to Docker Hub

1. Tag the Docker Images:
```
docker tag urgentnews-frontend ayaabusoud/urgent_news_backend:latest
docker tag urgentnews-backend ayaabusoud/urgent_news_frontend:latest
docker tag mysql ayaabusoud/urgent_news_db:latest
```
Explanation: These commands tag the built Docker images with the specified names and versions for pushing to Docker Hub.

2. Log in to Docker Hub:
```
docker login
```
Explanation: This command prompts the user to enter Docker Hub credentials to log in.

3. Push the Docker Images to Docker Hub:
```
docker push ayaabusoud/urgent_news_backend:latest
docker push ayaabusoud/urgent_news_frontend:latest
docker push ayaabusoud/urgent_news_db:latest
```


## Run the Images 

1. Run the Database Container:
```
docker run -d -p 3306:3306 --name urgent_news_db_container urgent_news_db
```

2. Run the Backend Container:
```
docker run -d -p 5000:5000 --name urgent_news_container  urgent_news _backend.
```

3. Run the Frontend Container:
```
docker run -d -p 8080:80 --name urgent_news_container  urgent_news
```

## Run Complete Application Using Docker Compose
```
docker-compose build
```

Go to following url in your browser to see the result
```
http://localhost
```