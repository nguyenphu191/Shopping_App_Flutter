const Counter = require('../models/Counter');
const Product = require('../models/ProductModel');
const User = require('../models/UserModel');
const bcrypt = require('bcrypt');

async function getNextSequence(name) {
    const counter = await Counter.findOneAndUpdate(
      { name },
      { $inc: { seq: 1 } },
      { new: true, upsert: true }  
    );
    return counter.seq;
  }

exports.addProduct = async (req, res) => {
    const { userId } = req.params;
    // const img = req.file.path;
    const { name, description, address, imgs, sold, colors, sizes, category, variants } = req.body;
    const SellerID =userId;
    
    try {
        
        const user = await User.findOne({ id: userId });
        if (!user) {
          return res.status(404).json({ message: "Seller không tồn tại!" });
        }
        const nextId = await getNextSequence('Product');
        const id = `P${nextId.toString().padStart(4, '0')}`;
        const rating = 0.0;
        const numberrate = 0;
        const product = await Product.create({
            id,
            SellerID,
            name,
            description,
            address,
            imgs,
            sold,
            category,
            colors,
            sizes,
            rating,
            numberrate,
            variants,
        });    
        res.status(200).json({ message: 'Success', product: product,user: user });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
        console.error("Lỗi trong quá trình thêm sản phẩm:", error);

    }
}

exports.getUserProducts = async (req, res) =>{
    const { userId } = req.params;
    try{
        const products = await Product.find({ SellerID: userId});
        res.status(200).json(products);
    }catch(e){
        res.status(500).json({ message: 'Server error', error });
    }
   
}

exports.getPopularProducts = async (req, res) => {
    try {
        const products = await Product.find().sort({ sold: -1 }).limit(20);
        res.status(200).json(products);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
}


exports.getProduct = async (req, res) => {
    const { id } = req.params;
    try {
        const product = await Product.findOne({ id });  
        if (!product) {
            return res.status(404).json({ message: 'Product not found' });
        }
        res.status(200).json(product);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
}

exports.updateProduct = async (req, res) => {
    const { id } = req.params;
    const { name, price, description, image, address, img, quantity, category,discount } = req.body;
    try {
        const product = await Product.findOne({ id });
        if (!product) {
            return res.status(404).json({ message: 'Product not found' });
        }
        product.name = name;
        product.price = price;
        product.description = description;
        product.image = image;
        product.address = address;
        product.img = img;
        product.quantity = quantity;
        product.category = category;
        product.discount = discount;
        await product.save();
        res.status(200).json({ message: 'Product updated successfully' });
    }
    catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
}

exports.deleteProduct = async (req, res) => {
    const { id } = req.params;
    try {
        const product = await Product.findOne({ id });
        if (!product) {
            return res.status(404).json({ message: 'Product not found' });
        }
        await product.remove();
        res.status(200).json({ message: 'Product deleted successfully' });
    }
    catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
}
exports.getAllProducts = async (req, res) => {
    try {
        const products = await Product.find().sort({sold: -1});
        res.status(200).json({products:products});
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
}

exports.searchProduct = async (req, res) => {
    const { key } = req.params;
    try {
        const products = await Product.find({ name: { $regex: key, $options: 'i' } });
        res.status(200).json({products:products});
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
}