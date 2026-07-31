import axios from 'axios';

// REACT_APP_API_URL is baked in at build time (see Dockerfile / .env)
// e.g. http://<backend-ec2-public-ip>:5000/api
const api = axios.create({
  baseURL: process.env.REACT_APP_API_URL || 'http://localhost:5000/api',
});

export default api;
