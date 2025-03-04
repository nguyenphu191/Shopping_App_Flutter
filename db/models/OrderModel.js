const mongoose = require('mongoose');

const OrderSchema = new mongoose.Schema({
    id: {type: String, required: true, unique: true},
    cartList:{ type: mongoose.Schema.Types.Mixed },
    total: {type: Number, required: true},
    status: {type: String, required: true},
    methodPayment: {type: String, required: true},
    isPaymented: {type: Boolean, required: true},
    reciever: {type: String, required: true},
    phone: {type: String, required: true},
    address: {type: String, required: true},
    time: {type: String, required: true},
    userID: {type: String, required: true},
    dateComplete: {type: String, required: false},
    rating: {type: Boolean, required: true},
});

const Order = mongoose.model('Order', OrderSchema);
module.exports = Order;