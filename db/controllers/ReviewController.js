const Review = require("../models/ReviewModel");
const Counter = require('../models/Counter');
const bcrypt = require('bcrypt');
const Order = require('../models/OrderModel');
const Product = require('../models/ProductModel');

async function getNextSequence(name) {
    const counter = await Counter.findOneAndUpdate(
      { name },
      { $inc: { seq: 1 } },
      { new: true, upsert: true }  
    );
    return counter.seq;
}

exports.addReview = async (req, res) => {
    const { userId, orderId, content, rate } = req.body;
    const { productId } = req.params;
    const date = new Date().toISOString();

    try {
        const nextId = await getNextSequence('Review');
        const id = `Rv${nextId.toString().padStart(8, '0')}`;

        const review = await Review.create({
            id,
            productId,
            userId,
            orderId,
            content,
            rate,
            date
        });

        await Order.findOneAndUpdate({ id: orderId }, { rating: true });

        const product = await Product.findOne({ id: productId });

        if (!product) {
            return res.status(404).json({ message: "Product not found" });
        }

        const numberrate = product.numberrate ; 
        const currentRating = product.rating ; 
        const newNumberRate = numberrate + 1;
        const newRating = (currentRating + rate) / newNumberRate;

        await Product.updateOne(
            { id: productId },
            { 
                numberrate: newNumberRate,
                rating: newRating
            }
        );

        res.status(200).json(review);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
        console.error("Lỗi trong quá trình thêm review:", error);
    }
};


exports.getReview = async (req, res) => {
    const { productId } = req.params;
    try {
        const reviews = await Review.find({ productId });
        res.status(200).json(reviews);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
        console.error("Lỗi trong quá trình lấy review:", error);
    }
}
exports.updateReview = async (req, res) => {
    const { reviewId } = req.params;
    const { content, rate} = req.body;
    const date = new Date().toISOString();
    try {
        const review = await Review.findOneAndUpdate({ id: reviewId }, { content, rate, date }, { new: true });
        res.status(200).json(review );
    }
    catch (error) {
        res.status(500).json({ message: 'Server error', error });
        console.error("Lỗi trong quá trình cập nhật review:", error);
    }
}
exports.deleteReview = async (req, res) => {
    const { reviewId } = req.params;
    try {
        await Review.findOneAndDelete({ id: reviewId });
        res.status(200).json({ message: 'Success' });
    }   
    catch (error) {
        res.status(500).json({ message: 'Server error', error });
        console.error("Lỗi trong quá trình xóa review:", error);
    }
}
exports.getReviewById = async (req, res) => {
    const { reviewId } = req.params;
    try {
        const review = await Review.findOne({ id: reviewId });
        res.status(200).json(review);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
        console.error("Lỗi trong quá trình lấy review:", error);
    }
}
