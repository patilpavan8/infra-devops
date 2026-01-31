# 🐳 Dockerized Flask Web App

This project demonstrates how to containerize a simple **Flask web application** using **Docker** and **Docker Compose**.  
It is ideal for showcasing Docker fundamentals on your GitHub profile.

---

## 🚀 Features

- Flask web application
- Dockerfile for building the image
- Docker Compose for easy container management
- Beginner-friendly and recruiter-ready

---

## 📁 Project Structure

```
docker-flask-app/
├── app/
│   ├── main.py
│   ├── requirements.txt
├── Dockerfile
├── docker-compose.yml
└── README.md
```

---

## 🧩 Flask Application

**app/main.py**
```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Docker World!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

---

## 📦 Requirements

**app/requirements.txt**
```
Flask==2.3.2
```

---

## 🐳 Dockerfile

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

EXPOSE 5000

CMD ["python", "main.py"]
```

---

## 🔧 Docker Compose

```yaml
version: '3.9'

services:
  web:
    build: .
    ports:
      - "5000:5000"
```

---

## ▶️ How to Run

### Using Docker
```bash
docker build -t flask-docker-app .
docker run -p 5000:5000 flask-docker-app
```

### Using Docker Compose
```bash
docker-compose up --build
```

Open your browser at:  
👉 http://localhost:5000

---

Happy Dockering! 🐳🔥
