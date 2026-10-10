FROM node:18-alpine

WORKDIR /usr/src/app

# Install production dependencies first so this layer is cached between builds
COPY package*.json ./
RUN npm install --omit=dev && npm cache clean --force

COPY . .

# Run as the non-root "node" user that ships with the official Node image
USER node

EXPOSE 5000

# Uses the /api/health route defined in server.js
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost:5000/api/health || exit 1

CMD ["node", "server.js"]
