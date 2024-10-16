const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const cors = require('cors');
const Detail = require('./models/Detail');
const DetailRoutes = require('./routes/DetailRoutes');
const DeviceRoutes = require('./routes/DeviceRoutes');
const Counter = require('./models/Counter');
const mqtt = require('mqtt');
const { format } = require('date-fns');
const DeviceHis = require('./models/DeviceHis');


mongoose.connect('mongodb://localhost:27017/smart_home');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Kết nối tới Mosquitto Broker cục bộ với username và password
const mqttOptions = {
  host: '172.20.10.2',  // Địa chỉ IP của máy chạy Mosquitto broker
  port: 1889,  
  username: 'Phu',
  password: 'B21DCCN592',
  protocol: 'mqtt'
};
const client = mqtt.connect(mqttOptions);
client.on('connect', () => {
  console.log('MQTT connected');
  
  client.subscribe('esp8266/dht11', (err) => {
    if (!err) {
      console.log('Subscribed to topic esp8266/dht11');
    } else {
      console.error('Failed to subscribe:', err);
    }
  });
});

async function getNextSequence(name) {
  const counter = await Counter.findOneAndUpdate(
    { name },
    { $inc: { seq: 1 } },
    { new: true, upsert: true }  
  );
  return counter.seq;
}

client.on('message', async (topic, message) => {
  try {
    const data = JSON.parse(message.toString());  // Chuyển đổi dữ liệu từ JSON
    const { nhiet_do, do_am, anh_sang } = data;

    const nextId = await getNextSequence('Detail');

    const newDetail = new Detail({
      id: `t${nextId}`, 
      nhiet_do,
      do_am,
      anh_sang,
      thoi_gian: format(new Date().toISOString(), 'yyyy-MM-dd HH:mm:ss'),
    });

    // Lưu dữ liệu vào MongoDB
    newDetail.save()
      .then(() => {
        console.log('Data saved:', newDetail);
      })
      .catch((err) => {
        console.error('Error saving data:', err);
      });
  } catch (err) {
    console.error('Error processing message:', err);
  }
});
app.post('/api/controlled_device', async (req, res) => {
  try{
    const { device, action } = req.body;
  const topic = `esp8266/${device}`;
  let name="";
  if(device==="device1"){
    name="Quạt";
  }else if(device==="device2"){
    name="Đèn";
  }else if(device==="device3"){
    name="Điều hòa";
  }
  if (action === "ON" || action === "OFF") {
    client.publish(topic, action, (error) => {
      if (error) {
        return res.status(500).json({ message: 'Error controlling' });
      }
      res.status(200).json({ message: `${device} turned ${action}` });
    });
    const nextId = await getNextSequence('DeviceHis');

    const newDevicehis = new DeviceHis({
      id: `t${nextId}`,
      ten: name,
      tinh_trang: action,
      thoi_gian: format(new Date().toISOString(), 'yyyy-MM-dd HH:mm:ss'),
    });
    newDevicehis.save()
      .then(() => {
        console.log('Data saved:', newDevicehis);
      })
      .catch((err) => {
        console.error('Error saving data:', err);
      });
  } else {
    res.status(400).json({ message: 'Invalid action' });
  }
  }catch{
    console.error('Error processing request:', err);
    res.status(500).json({ message: 'Error processing request' });
  }
});

client.on('error', (err) => {
  console.error('MQTT error:', err);
});


// Sử dụng routes
app.use('/api/details', DetailRoutes);
app.use('/api/devicehis', DeviceRoutes);

// Khởi động server
const PORT = 8000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});