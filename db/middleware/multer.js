const multer = require('multer');
const path = require('path');

// Cấu hình Multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, '../uploads/')); // Đường dẫn chính xác đến thư mục uploads
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); // Đặt tên file với timestamp
  },
});

// Khởi tạo upload
const upload = multer({ storage: storage });

module.exports = upload;
