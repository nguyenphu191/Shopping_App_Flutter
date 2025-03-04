const express = require("express");
const router = express.Router();
const ReviewController = require("../controllers/ReviewController");

router.post('/addreview/:productId', ReviewController.addReview);
router.get('/getreviews/:productId', ReviewController.getReview);
 router.get('/getreview/:reviewId', ReviewController.getReviewById);
router.patch('/updatereview/:reviewId', ReviewController.updateReview);
router.delete('/deletereview/:reviewId', ReviewController.deleteReview);

module.exports = router;
