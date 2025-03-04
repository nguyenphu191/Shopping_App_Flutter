const express = require("express");
const router = express.Router();
const UserController = require("../controllers/UserController");

router.post("/login", UserController.login);
router.post("/register", UserController.register);
router.get("/getuser/:userId", UserController.getUser);
router.get("/getusers", UserController.getAllUsers);
router.patch("/update/:userId", UserController.updateUser);
router.delete("/delete/:userId", UserController.deleteUser);
module.exports = router;
