require('dotenv').config();
const express = require('express');
const cors = require('cors');
const connectDB = require('./config/db');
const authRoutes = require('./routes/auth');

const app = express();

// Connect to MongoDB (Atlas or self-hosted, based on MONGO_URI)
connectDB();

// Middleware
app.use(cors());
app.use(express.json());

// Health check — useful for confirming the container/EC2 instance is alive
app.get('/api/health', (req, res) => {
  res.status(200).json({ status: 'ok', service: 'backend' });
});

// Routes
app.use('/api/auth', authRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Backend server running on port ${PORT}`);
});
