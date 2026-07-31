const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGO_URI);
    console.log(`MongoDB connected: ${conn.connection.host}`);
  } catch (err) {
    console.error(`MongoDB connection error: ${err.message}`);
    // Exit process on failure so Docker/EC2 restarts the container instead
    // of running with a dead DB connection
    process.exit(1);
  }
};

module.exports = connectDB;
