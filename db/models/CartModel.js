const mongoose = require('mongoose');

cartItemSchema = new mongoose.Schema({
    id: { type: String, required: true },
    cusID: { type: String, required: true },
    sellID: { type: String, required: true },
    sellName: { type: String, required: true },
    product: { type: mongoose.Schema.Types.Mixed},
    color: { type: String, required: false },
    size: { type: String, required: false },
    price: { type: Number, required: true },
    quantity: { type: Number, required: true },
    time: { type: String, required: true },
});
const CartItem = mongoose.model("CartItem", cartItemSchema);

module.exports = CartItem;