const User = require("../models/UserModel");
const Counter = require('../models/Counter');
const bcrypt = require('bcrypt');


async function getNextSequence(name) {
    const counter = await Counter.findOneAndUpdate(
      { name },
      { $inc: { seq: 1 } },
      { new: true, upsert: true }  
    );
    return counter.seq;
  }
// Đăng nhập và trả về dữ liệu đầy đủ của từng loại
exports.login = async (req, res) => {
  const { username, password } = req.body;
  console.log(username, password);
  try {
    const user = await User.findOne({ username });
    if (!user) {
      return res.status(401).json({ message: "Invalid username" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid password" });
    }

    // Phân loại dựa trên ID
    let role;
    if (user.id.startsWith("cus")) {
      role = "Customer";
    } else if (user.id.startsWith("sel")) {
      role = "Seller";
    } else if (user.id.startsWith("adm")) {
      role = "Admin";
    }

    res.status(200).json({ user, role });
  } catch (error) {
    res.status(500).json({ message: "Server error", error });
  }
};

exports.register = async (req, res) => {
  const { username, role, email, phone, password, address } = req.body;
  try {
    // Kiểm tra xem email hoặc username đã tồn tại chưa
    const existingUser = await User.findOne({ $or: [{ email }, { username }] });
    if (existingUser) {
      return res.status(400).json({ message: 'Email hoặc username đã được sử dụng!' });
    }

    // Mã hóa mật khẩu
    const hashedPassword = await bcrypt.hash(password, 10);
    let id="";
    if(role === 'Customer') {
        const nextId = await getNextSequence('Customer');
        id = `cus_${nextId.toString().padStart(3, '0')}`;
    } else if(role === 'Seller') {
        const nextId = await getNextSequence('Seller');
        id = `sel_${nextId.toString().padStart(3, '0')}`;
    }else{
        const nextId = await getNextSequence('Admin');
        id = `adm_${nextId.toString().padStart(3, '0')}`;
    }
    // Tạo tài khoản mới
    const user = await User.create({
        id,
        username,
        email,
        phone,
        password: hashedPassword,
        address,
        productList: [],
        orderList: [],
        cartList: [],
    });

    res.status(200).json({ message: 'Đăng ký thành công!', user });
  } catch (error) {
    res.status(500).json({ message: 'Lỗi server!', error: error.message });
  }
};

exports.getAllUsers = async (req, res) => {
  try {
    const users = await User.find();
    res.status(200).json({ users });
  } catch (error) {
    res.status(500).json({ message: 'Lỗi server!', error: error.message });
  }
}
exports.updateUser = async (req, res) => {
  const { userId } = req.params;
  const { username, email, phone, address } = req.body;
  
  try {
    

    // Giả sử bạn sử dụng MongoDB
    const updatedUser = await User.findOne({id: userId});
    if (!updatedUser) {
      return res.status(404).json({ message: 'User không tồn tại!' });
    }
    if (username) updatedUser.username = username;
    if (phone) updatedUser.phone = phone;
    if (email) updatedUser.email = email;
    if (address) updatedUser.address = address;
    await updatedUser.save();
    res.status(200).json({ message: 'User updated successfully', updatedUser });
    
  } catch (error) {
    res.status(500).json({ message: 'Lỗi server!', error: error.message });
  }
}

exports.deleteUser = async (req, res) => {
  const { userId } = req.params;
  try {
    const user = await User.findOne({ id: userId });
    if (!user) {
      return res.status(404).json({ message: 'User không tồn tại!' });
    }
    await user.remove();
    res.status(200).json({ message: 'User deleted successfully' });
  }
  catch (error) {
    res.status(500).json({ message: 'Lỗi server!', error: error.message });
  }
}

exports.getUser =async (req, res) => {
  const { userId } = req.params;
  try {
    const user = await User.findOne({ id: userId });
    if (!user) {
      return res.status(404).json({ message: 'User không tồn tại!' });
    }
    res.status(200).json({ user });
  } catch (error) {
    res.status(500).json({ message: 'L��i server!', error: error.message });
  }
}