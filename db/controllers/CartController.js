const Counter = require('../models/Counter');
const bcrypt = require('bcrypt');
const User = require('../models/UserModel');
const CartItem = require('../models/CartModel');
const Product = require('../models/ProductModel');

async function getNextSequence(name) {
    const counter = await Counter.findOneAndUpdate(
      { name },
      { $inc: { seq: 1 } },
      { new: true, upsert: true }  
    );
    return counter.seq;
  }

exports.addToCart = async (req, res) => {
    const { userId } = req.params;
    const { productID,sellID, quantity, color, size, price } = req.body;
    const time = new Date().toISOString();
    
    try {
        const user = await User.findOne({ id: userId });
        if (!user) {
          return res.status(404).json({ message: "User không tồn tại!" });
        }
        const sell = await User.findOne({ id: sellID });
        if (!sell) {
            return res.status(404).json({ message: "Seller không tồn tại!" });
        }
        const sellName = sell.username;
        const product = await Product.findOne({id: productID});
        
        if (!product) {
            return res.status(404).json({ message: "Product không tồn tại!" });
        }
        const cartList = await CartItem.find({cusID: userId});
        if(cartList.find(cartItem => (cartItem.product.id == productID && cartItem.color === color && cartItem.size === size))){
            await CartItem.findOneAndUpdate(
                { cusID: userId, 'product.id': productID, color: color, size: size },
                { $inc: { quantity: 1 } },
                {time},
                { new: true }
            );
        }else{
            const nextId = await getNextSequence('CartIteam');
            const id = `CI${nextId.toString().padStart(8, '0')}`;
            await CartItem.create({
                id,
                cusID: userId,
                sellID,
                sellName,
                product,
                color,
                size,
                price,
                quantity,
                time
            });
        }
        const updatedCartList = await CartItem.find({cusID: userId});
        res.status(200).json(updatedCartList);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
        console.error("Lỗi ", error);

    }
}
exports.getCart = async (req, res) =>{
    const { userId } = req.params;
    try {
        const user = await User.findOne({ id: userId });
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }
        const cartItems = await CartItem.find(
            { cusID: userId }
        ).sort({ time: -1 });
        res.status(200).json(cartItems);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
}
exports.updateCart = async (req, res) => {
    const { id } = req.params;
    const { isAdd } = req.body;

    const time = new Date().toISOString();
    try {
        // Tìm mục giỏ hàng dựa trên id
        const cartItem = await CartItem.findOne({ id: id });
        if (!cartItem) {
            return res.status(404).json({ message: 'Cart item not found' });
        }

        const cusID = cartItem.cusID; 
        let updatedCartItem;

        if (isAdd) {
            updatedCartItem = await CartItem.findOneAndUpdate(
                { id },
                { $inc: { quantity: 1 }, time: time },
                { new: true }
            );
        } else {
            if (cartItem.quantity === 1) {
                await CartItem.deleteOne({ id });

                const updatedCartList = await CartItem.find({ cusID });
                return res.status(200).json({
                    message: 'Delete success',
                    cartList: updatedCartList
                });
            } else {
                updatedCartItem = await CartItem.findOneAndUpdate(
                    { id },
                    { $inc: { quantity: -1 }, time: time },
                    { new: true }
                );
            }
        }

        const updatedCartList = await CartItem.find({ cusID: cusID });
        res.status(200).json(
            updatedCartList
        );
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
};

exports.deleteCart = async (req, res) => {
    const { id } = req.params;
    try {
        const item = await CartItem.findOne({id: id });
        const userId = item.cusID;
        await CartItem.deleteOne({ id: id });
        const cartItems = await CartItem.find({cusID: userId});
        res.status(200).json(cartItems);
    }
    catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
}