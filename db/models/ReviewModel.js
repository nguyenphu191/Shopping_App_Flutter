const mongoose = require('mongoose');

ReviewSchema = new mongoose.Schema({
    id: { type: String, required: true },
    productId: { type: String, required: true },
    userId: { type: String, required: true },
    orderId: { type: String, required: true },
    content: { type: String, required: true },
    rate: { type: Number, required: true },
    date: { type: String, required: true },
});
const Review = mongoose.model("Review", ReviewSchema);
module.exports = Review;