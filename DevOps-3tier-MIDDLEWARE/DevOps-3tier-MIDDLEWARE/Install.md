# **3‑Tier Deployment Guide (No Docker) — EC2 + Node.js + Nginx**

This guide covers deploying your **frontend**, **backend**, and **reverse proxy** across three separate EC2 instances using **Node.js**, **npm**, and **Nginx** — no containers.

---

## **Architecture Overview**

| Tier | EC2 Instance | Port | Notes |
|------|--------------|------|-------|
| Frontend | Server 1 | 4500 | React dev server (or PM2) |
| Backend | Server 2 | 5000 | Node.js API |
| Reverse Proxy | Server 3 | 80 | Nginx routing `/` → frontend and `/api` → backend |

---

# **Server 1 — Frontend Setup**

SSH:

```bash
ssh -i your-key.pem ubuntu@<frontend-public-ip>
```

### **Install base tools**

```bash
sudo apt update
sudo apt install -y curl git
```

### **Install Node.js (LTS)**

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```

### **Clone repo & install dependencies**

```bash
git clone <your-repo-url>.git
cd DevOps-3tier-MIDDLEWARE/frontend
npm install
```

### **Configure API endpoint**

```bash
echo "REACT_APP_API_URL=http://<nginx-public-ip>/api" > .env
```

### **Run frontend**

#### Option A — Dev server (foreground)

```bash
PORT=4500 npm start
```

#### Option B — PM2 (recommended)

```bash
sudo npm install -g pm2
PORT=4500 pm2 start npm --name frontend -- start
pm2 save
```

---

# **Server 2 — Backend Setup**

SSH:

```bash
ssh -i your-key.pem ubuntu@<backend-public-ip>
```

### **Install base tools + Node.js**

Same as frontend:

```bash
sudo apt update
sudo apt install -y curl git
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```

### **Clone repo & install dependencies**

```bash
git clone <your-repo-url>.git
cd DevOps-3tier-MIDDLEWARE/backend
npm install
```

### **Configure environment**

```bash
cp .env.example .env
nano .env
```

Set:

```
MONGO_URI=<your-atlas-connection-string>
JWT_SECRET=<your-secret>
```

### **Run backend**

```bash
sudo npm install -g pm2
pm2 start server.js --name backend
pm2 save
```

### **Health check**

```bash
curl http://localhost:5000/api/health
```

---

# **Server 3 — Nginx Reverse Proxy**

SSH:

```bash
ssh -i your-key.pem ubuntu@<nginx-public-ip>
```

### **Install Nginx**

```bash
sudo apt update
sudo apt install -y nginx
```

### **Configure reverse proxy**

Edit default site:

```bash
sudo nano /etc/nginx/sites-available/default
```

Paste:

```nginx
server {
    listen 80;
    server_name _;

    location /api/ {
        proxy_pass http://<backend-private-ip>:5000/api/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location / {
        proxy_pass http://<frontend-private-ip>:4500/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### **Restart Nginx**

```bash
sudo nginx -t
sudo systemctl restart nginx
```

---

# **Security Groups (Important)**

To allow Nginx to reach the other servers:

### **Frontend SG**
- Inbound: **TCP 4500**
- Source: **sg-nginx**

### **Backend SG**
- Inbound: **TCP 5000**
- Source: **sg-nginx**

Without these rules, Nginx → frontend/backend traffic will fail.

---

# **Final Test**

Open:

```
http://<nginx-public-ip>
```

You should see your React app, and API calls should route through:

```
http://<nginx-public-ip>/api
```

---

If you want, I can also generate a **README.md** version for your GitHub repo or a **diagram.md** with architecture visuals.
