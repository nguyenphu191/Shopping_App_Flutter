const mongoose = require('mongoose');

const DetailSchema = new mongoose.Schema({
  id: { type: String, required: true },
  nhiet_do: { type: Number, required: true },
  do_am: { type: Number, required: true},
  anh_sang: { type: Number, required: true },
  thoi_gian: { type: String, required: true }
});

module.exports = mongoose.model('Detail', DetailSchema);