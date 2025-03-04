const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  id: { type: String, required: true, unique: true }, 
  username: { type: String, required: true },
  email: { type: String, required: true },
  phone: { type: String, required: true },
  password: { type: String, required: true },
  address: { type: mongoose.Schema.Types.Mixed },
});

const User = mongoose.model("User", userSchema);
module.exports = User;
