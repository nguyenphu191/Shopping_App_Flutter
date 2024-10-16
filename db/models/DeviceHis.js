const mongoose = require('mongoose');
const AutoIncrement = require('mongoose-sequence')(mongoose);

const DeviceHisSchema = new mongoose.Schema({
  id: {type: String, unique: true },
  ten: {type: String,required: true},
  tinh_trang: {type: String,required: true},
  thoi_gian: {type: String,required: true}
});

// Trước khi lưu, tạo một id tự động
// DeviceHisSchema.pre('save', async function (next) {
//   if (!this.id) {
//     const count = await mongoose.model('DeviceHis').countDocuments() + 1;
//     this.id = `dv_${String(count).padStart(3, '0')}`;
//   }
//   next();
// });
 
module.exports = mongoose.model('DeviceHis', DeviceHisSchema);
