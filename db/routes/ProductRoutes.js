const express = require("express");
const router = express.Router();
const upload = require('../middleware/multer');
const UserController = require("../controllers/ProductController");

// router.post('/addproduct/:sellerId',upload.single('image'), UserController.addProduct);
router.post('/addproduct/:userId', UserController.addProduct);
router.get('/getproducts/:userId', UserController.getUserProducts);
router.get('/getproducts', UserController.getAllProducts);
router.get('/getpopular', UserController.getPopularProducts);
router.get('/getproduct/:id', UserController.getProduct);
router.get('/searchproduct/:key', UserController.searchProduct);
router.patch('/updateproduct/:id', UserController.updateProduct);
router.delete('/deleteproduct/:id', UserController.deleteProduct);

module.exports = router;