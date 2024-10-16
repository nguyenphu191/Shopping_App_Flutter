const express = require('express');
const router = express.Router();
const DeviceHis = require('../models/DeviceHis');
const Counter = require('../models/Counter');

// Lưu một lịch sử thiết bị mới (DeviceHis)
async function getNextSequence(name) {
  const counter = await Counter.findOneAndUpdate(
    { name },
    { $inc: { seq: 1 } },
    { new: true, upsert: true }  
  );
  return counter.seq;
}
// router.post('/', async (req, res) => {

//   const { ten, tinh_trang, thoi_gian } = req.body;
//   const nextId = await getNextSequence('DeviceHis');
//   const newDeviceHis = new DeviceHis({
//     id: `dv_${nextId.toString().padStart(3, '0')}`, 
//     ten,
//     tinh_trang,
//     thoi_gian
//   });

//   try {
//     await newDeviceHis.save();
//     res.status(201).send(newDeviceHis);
//   } catch (error) {
//     res.status(500).send({ message: 'Error saving DeviceHis', error });
//   }
// });

// Tìm kiếm lịch sử thiết bị (DeviceHis) theo ON/OFF
router.get('/search', async (req, res) => {
  const { tinh_trang } = req.query;
  try {
    const devicehis = await DeviceHis.find({ tinh_trang: { $regex: tinh_trang, $options: 'i' } });

    res.json(devicehis);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
});

// router.get('/', async (req, res) => {  
//   try {
//     const deicehis = await DeviceHis.find()
//       .sort({ thoi_gian: -1 }) 
//       .exec();

//     res.json({
//       deicehis
//     });
//   } catch (error) {
//     console.error(error);
//     res.status(500).json({ message: 'Server error' });
//   }
// });
// Lấy danh sách lịch sử thiết bị (DeviceHis) với phân trang
router.get('/getByPage', async (req, res) => {
  const { page = 1, limit = 10 } = req.query;
  
  const deviceHistories = await DeviceHis.find()
    .sort({ thoi_gian: -1 })
    .limit(limit * 1)
    .skip((page - 1) * limit)
    .exec();

  const count = await DeviceHis.countDocuments();
  res.json({
    deviceHistories,
    totalPages: Math.ceil(count / limit),
    currentPage: page
  });
});

module.exports = router;
