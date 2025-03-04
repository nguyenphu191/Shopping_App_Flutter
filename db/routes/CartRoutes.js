const express = require("express");
const router = express.Router();
const CartController = require("../controllers/CartController");

router.post('/addtocart/:userId', CartController.addToCart);
router.get('/getcart/:userId', CartController.getCart);
router.patch('/updatecart/:id', CartController.updateCart);
router.delete('/deletecart/:id', CartController.deleteCart);

module.exports = router;