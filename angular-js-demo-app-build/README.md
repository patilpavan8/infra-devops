# AngularJS Task Manager (Dockerized)

This project is a simple **AngularJS Task Manager application** that is
containerized using **Docker** and served via **Nginx**.\
The application runs fully in the browser.

------------------------------------------------------------------------

## 🚀 Features

-   Add new tasks
-   Mark tasks as completed
-   Delete tasks
-   Runs inside Docker
-   Served using Nginx

------------------------------------------------------------------------

## 📁 Project Structure

    task-manager/
    ├── app/
    │   ├── index.html
    │   ├── app.js
    │   ├── controllers.js
    │   └── styles.css
    ├── Dockerfile
    ├── nginx.conf
    └── README.md

------------------------------------------------------------------------

## 🛠 Prerequisites

-   Docker installed
-   Web browser (Chrome, Firefox, etc.)

------------------------------------------------------------------------

## 🔧 Build and Run Instructions

### 1️⃣ Clone or Download the Project

``` bash
git clone <your-repo-url>
cd task-manager
```

### 2️⃣ Build the Docker Image

``` bash
docker build -t angularjs-task-manager .
```

### 3️⃣ Run the Docker Container

``` bash
docker run -d -p 8080:80 angularjs-task-manager
```

### 4️⃣ Open in Browser

Visit:

    http://localhost:8080

------------------------------------------------------------------------

## 🐳 Docker Details

-   Base Image: `nginx:alpine`
-   AngularJS files are served from `/usr/share/nginx/html`
-   Nginx runs on port `80` inside the container

------------------------------------------------------------------------

## 📌 Future Enhancements

-   Save tasks using `localStorage`
-   Add task filters
-   Connect a backend API
-   Add authentication
-   Use Docker Compose

------------------------------------------------------------------------

## 📄 License

This project is open-source and free to use for learning purposes.
