# DevOps 3-Tier MIDDLEWARE

A 3-tier app: React frontend, Node/Express backend, MongoDB Atlas database.

## Architecture

```
[ Browser ]
     |
     v
[ Frontend EC2 ]  --- nginx serving React build, port 80
     |
     v  (calls REACT_APP_API_URL)
[ Backend EC2 ]   --- Node/Express in Docker, port 5000
     |
     v  (MONGO_URI)
[ MongoDB Atlas ] --- managed, in the cloud, not on either EC2
```

Two EC2 instances, each running one Docker container. MongoDB is not
self-hosted — it's a managed Atlas cluster, so there's no database server
to patch, back up, or run out of disk space on.

## Folder structure

```
DevOps-3tier-MIDDLEWARE/
├── docker-compose.yml        # local dev only — spins up mongo+backend+frontend together
├── README.md
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   ├── server.js
│   ├── .env.example
│   ├── config/db.js
│   ├── middleware/authMiddleware.js
│   ├── models/User.js
│   └── routes/auth.js
└── frontend/
    ├── Dockerfile
    ├── package.json
    ├── public/index.html
    └── src/
        ├── api/axios.js
        ├── components/Navbar.jsx
        ├── pages/Login.jsx
        ├── pages/Register.jsx
        ├── App.jsx
        ├── index.js
        └── index.css
```

## What's implemented

A working register/login flow: Express routes hash passwords with bcrypt,
issue JWTs, and a protected `/api/auth/me` route reads them back via
middleware. The React side has matching Login/Register pages wired to the
API through an axios instance. It's a real, running skeleton, not just
folder stubs — this is meant to be a starting point you build on.

## Deployment (see chat for the full step-by-step walkthrough)

1. Create a MongoDB Atlas cluster, get the connection string
2. Launch backend EC2 → install Docker → build/run backend container with `MONGO_URI` pointed at Atlas
3. Launch frontend EC2 → install Docker → build/run frontend container with `REACT_APP_API_URL` pointed at the backend EC2's public IP
4. Open the right ports in each instance's security group
