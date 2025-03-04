const express = require("express");
const mongoose = require("mongoose");
const userRoutes = require("../routes/UserRoutes");
const productRoutes = require("../routes/ProductRoutes");
const cartRoutes = require("../routes/CartRoutes");
const orderRoutes = require("../routes/OrderRoutes");
const reviewRoutes = require("../routes/ReviewRoutes");
const cors = require("cors");

mongoose.connect('mongodb://localhost:27017/Shopping_app');
const app = express();
app.use(express.json());
app.use(cors());

// Routes
app.use("/api/users", userRoutes);
app.use("/api/products", productRoutes);
app.use("/api/carts", cartRoutes);
app.use("/api/orders", orderRoutes);
app.use("/api/reviews", reviewRoutes);

// Khởi động server
const PORT = 8000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
