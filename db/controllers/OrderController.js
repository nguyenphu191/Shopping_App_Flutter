const Counter = require('../models/Counter');
const User = require('../models/UserModel');
const Order = require('../models/OrderModel');
const CartItem = require('../models/CartModel');
const Product = require('../models/ProductModel');
const bcrypt = require('bcrypt');

async function getNextSequence(name) {
    const counter = await Counter.findOneAndUpdate(
      { name },
      { $inc: { seq: 1 } },
      { new: true, upsert: true }  
    );
    return counter.seq;
  }
  exports.getInfor = async (req, res) => {
    const { cartItemList } = req.body;
    try {
        const cartList = await CartItem.find({
            id: { $in: cartItemList }
        });

        let total = 0;

        for (const cartItem of cartList) {
                total += cartItem.price * cartItem.quantity; // Tính tổng tiền
            
        }


        res.status(200).json({ message: 'success', cartList: cartList, total: total });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
        console.error("Lỗi trong quá trình lấy thông tin giỏ hàng:", error);
    }
};

exports.createOrder = async (req, res) => {
    const {userID, cartItemList, total, methodPayment, isPaymented, reciever, phone, address} = req.body;
   
    try {
        const user = await User.findOne({ id: userID });
        if (!user) {
          return res.status(404).json({ message: "User không tồn tại!" });
        }
        const nextId = await getNextSequence('Order');
        const id = `Od${nextId.toString().padStart(4, '0')}`;
        const rating=false;
        const cartList =await CartItem.find({
            id: { $in: cartItemList }
        });
        if (!cartList) {
            return res.status(404).json({ message: " Lỗi" });
        }
        const time = new Date().toISOString();
        const status = "pendingadmin";
        const dateComplete = "";

        const order = await Order.create({
            id,
            cartList,
            total,
            status,
            methodPayment,
            isPaymented,
            reciever,
            phone,
            address,
            time,
            userID,
            dateComplete,
            rating,
        });    
        const cartItemIds = cartList.map(item => item.id); 
        const deleteResult = await CartItem.deleteMany({ id: { $in: cartItemIds } });

        if (deleteResult.deletedCount !== cartList.length) {
            return res.status(500).json({ 
                message: "Không thể xóa hết các CartItem đã sử dụng!",
                deleted: deleteResult.deletedCount,
                expected: cartList.length,
            });
        }
        res.status(200).json({ message: 'success', order: order,user: user });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
        console.error("Lỗi trong quá trình tạo đơn hàng:", error);

    }
}

exports.getUserOrders = async (req, res) => {
    const {userID} = req.params;
    try{
        const user = await User.findOne({id: userID});
        if (!user) {
            return res.status(404).json({ message: "User không tồn tại!" });
        }
        const orders = await Order.find({ userID:userID }).sort({ time: -1 });
        res.status(200).json({ orders: orders});
    }catch (error) {
        res.status(500).json({ message: 'Server error', error });

    }
}

exports.getOrderById = async (req, res) => {
    const {id} = req.params;
    try{
        const order = await Order.findOne({id:id});
        if (!order) {
            return res.status(404).json({ message: "Order không tồn tại!" });
        }
        res.status(200).json({ order: order}); 
    }catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
}

exports.updateOrder = async (req, res) => {
    const {id} = req.params;
    const {status} = req.body;
    const dateComplete = new Date().toISOString();
    try{
        const order = await Order.findOneAndUpdate({id:id}, {status: status, dateComplete: dateComplete}, {new: true});
        if (!order) {
            return res.status(404).json({ message: "Đơn hàng không tồn tại!" });
        }
        if(status ==='delivered'){
            const cartList = order.cartList;
            const updatePromises = cartList.map(async (cartItem) => {
                const { productID, quantity } = cartItem;

                
                const product = await Product.findOne({id:productID});
                if (product) {
                    product.sold += quantity;
                    product.quantity -= quantity;

                    await product.save();
                }
            });
            await Promise.all(updatePromises);
        }   
        
        res.status(200).json({ message: 'success', order: order});
    }
    catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
}