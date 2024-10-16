const mongoose = require('mongoose');

// Tạo schema để lưu bộ đếm
const CounterSchema = new mongoose.Schema({
  name: { type: String, required: true },
  seq: { type: Number, required: true }
});

// Tạo model Counter
const Counter = mongoose.model('Counter', CounterSchema);

module.exports = Counter;
