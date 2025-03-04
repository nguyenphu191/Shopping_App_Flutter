const express = require("express");
const router = express.Router();
const OrderController = require("../controllers/OrderController");
router.post('/getInfor', OrderController.getInfor);
router.post('/create', OrderController.createOrder);
router.get('/get/:userID', OrderController.getUserOrders);
router.get('/getorderbyid/:id', OrderController.getOrderById);
router.patch('/update/:id', OrderController.updateOrder);

module.exports = router;
