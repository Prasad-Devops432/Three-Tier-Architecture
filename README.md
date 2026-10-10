# Three-Tier Web Application (DevOps Project)

A containerised three-tier application that I built to practise deploying a
full-stack app with separate frontend, backend, and database layers.

| Tier | Technology | Purpose |
|------|-----------|---------|
| Frontend | React, served by Nginx | Login and registration pages |
| Backend | Node.js, Express | REST API with JWT authentication |
| Database | MongoDB (Atlas in production, local container for development) | User accounts |

## What it does

- Users can register and log in.
- Passwords are hashed with bcrypt before they are stored.
- The backend issues a JWT on successful login, valid for seven days.
- A `/api/health` endpoint reports whether the backend is running.

## Repository layout

The application lives in the `DevOps-3tier-MIDDLEWARE/DevOps-3tier-MIDDLEWARE/`
folder. Its own README has the architecture diagram and a file-by-file walkthrough.

| File | Purpose |
|------|---------|
| `DevOps-3tier-MIDDLEWARE/DevOps-3tier-MIDDLEWARE/README.md` | Architecture and folder structure |
| `DevOps-3tier-MIDDLEWARE/DevOps-3tier-MIDDLEWARE/docker-compose.yml` | Runs the full stack locally with Docker |
| `DevOps-3tier-MIDDLEWARE/DevOps-3tier-MIDDLEWARE/Install.md` | Deployment without Docker, across three EC2 servers |
| `.../backend/Dockerfile`, `.../frontend/Dockerfile` | Container images for each tier |
| `.../frontend/nginx.conf` | Serves the React build and falls back to `index.html` for client-side routes |

## Running it locally with Docker

Requirements: Docker and Docker Compose.

```bash
cd DevOps-3tier-MIDDLEWARE/DevOps-3tier-MIDDLEWARE
docker compose up --build
```

Then open:

- Frontend: http://localhost:3000
- Backend health check: http://localhost:5000/api/health

The local compose file uses a placeholder JWT secret and a local MongoDB
container. Do not use those values in a real deployment.

## Deploying to AWS

Two deployment paths are documented:

1. **Containers:** build and run each Dockerfile on its own EC2 instance, with
   MongoDB Atlas as the database. Pass the backend's public address to the
   frontend build with the `REACT_APP_API_URL` build argument.
2. **Without Docker:** follow `Install.md`, which sets up Node.js and Nginx on
   three separate EC2 instances.

## Configuration

The backend reads its settings from environment variables. Copy the example file
and fill in your own values. Never commit the real `.env` file.

```bash
cp DevOps-3tier-MIDDLEWARE/DevOps-3tier-MIDDLEWARE/backend/.env.example \
   DevOps-3tier-MIDDLEWARE/DevOps-3tier-MIDDLEWARE/backend/.env
```

| Variable | Purpose |
|----------|---------|
| `MONGO_URI` | MongoDB connection string |
| `JWT_SECRET` | Long random string used to sign tokens |
| `PORT` | Backend port (default 5000) |

## Concepts demonstrated

- Serving a single-page React app from Nginx with a fallback for client-side routes.
- Keeping secrets out of container images using `.dockerignore` and environment variables.
- Running the backend container as a non-root user with a health check.
- Protecting an API route with JWT middleware (`GET /api/auth/me`).
- Using a managed cloud database instead of running one on an application server.

## Known limitations and next steps

- The frontend `REACT_APP_API_URL` value is set at build time, so changing the backend address requires rebuilding the frontend image.
- No automated tests yet.
- No CI/CD pipeline yet. A natural next step is a GitHub Actions workflow that builds and pushes both images.
- The frontend does not yet call `/api/auth/me` or include a logout action. The token is stored in `localStorage` after login.
