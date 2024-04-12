import 'package:flutter_shopping_app/models/OrderModel.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/models/product.dart';

ProductModel banhmithitnuong = ProductModel(
    name: 'Bánh mì thịt nướng',
    price: 20000,
    img: 'assets/image/banhmi.png',
    description:
        'Bánh mì thịt nướng là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ thịt nướng, rau sống, nước mắm, tương ớt, và bánh mì.',
    location: 'Hà Nội');
ProductModel bunbohue = ProductModel(
    name: 'Bún bò huế',
    price: 30000,
    description:
        'Bún bò Huế là một món ăn truyền thống nổi tiếng của miền Trung Việt Nam, đặc biệt là từ thành phố Huế. Món này thường được chế biến từ bún (bún là loại bún mì), thịt bò, huyết heo, hành, ngò, rau sống và gia vị.Cách chế biến bún bò Huế bao gồm việc nấu nước dùng từ xương bò và thịt bò, sau đó thêm các loại gia vị như ớt, bột nêm, mắm ruốc để tạo ra hương vị đặc trưng của món ăn này. Bún bò Huế thường được phục vụ nóng, kèm theo rau sống, giá, hành, ngò và chanh để tạo ra hương vị đặc trưng và thơm ngon.Bún bò Huế có hương vị đậm đà, cay nồng, thơm ngon và rất phổ biến trong ẩm thực Việt Nam.',
    img: 'assets/image/bun_bo_hue.jpg',
    location: 'Huế');
ProductModel bunrieu = ProductModel(
    name: 'Bún riêu',
    price: 25000,
    description:
        'Bún riêu là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ bún, nước dùng từ cua, cà chua, rau sống, mắm tôm, và các loại gia vị khác.',
    img: 'assets/image/bun_rieu.jpg',
    location: 'Hải Phòng');
ProductModel comtam = ProductModel(
    name: 'Cơm tấm',
    price: 25000,
    description:
        'Cơm tấm là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ cơm, thịt nướng, trứng, rau sống, nước mắm, tương ớt, và các loại gia vị khác.',
    img: 'assets/image/com_tam.jpg',
    location: 'Hà Nội');
ProductModel nemnuong = ProductModel(
    name: 'Nem nướng',
    price: 25000,
    description:
        'Nem nướng là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ thịt nướng, bún, rau sống, nước mắm, tương ớt, và các loại gia vị khác.',
    img: 'assets/image/nemnuong.jpg',
    location: 'Hải Dương');

List<ProductModel> productList = [
  banhmithitnuong,
  bunbohue,
  bunrieu,
  comtam,
  nemnuong
];

List<CartItem> cartList = [
  CartItem(product: banhmithitnuong, quantity: 1),
  // CartItem(product: bunbohue, quantity: 1),
  // CartItem(product: bunrieu, quantity: 1),
  // CartItem(product: comtam, quantity: 1),
  // CartItem(product: nemnuong, quantity: 1),
];
List<CartItem> cartList2 = [
  CartItem(product: banhmithitnuong, quantity: 1),
  CartItem(product: bunbohue, quantity: 1),
  CartItem(product: bunrieu, quantity: 1),
  CartItem(product: comtam, quantity: 1),
  CartItem(product: nemnuong, quantity: 1),
];
var total2 =0;


User user1 = User(
  username: "John",
  email: "john15@gmail.com",
  phone: "1234567890",
  password: "123456",
  city: "New York",
);
User user2 = User(
  username: "Jane",
  email: "jane685@gmail.com",
  phone: "9876543210",
  password: "123456",
  city: "Los Angeles",
);
List<User> userList = [user1, user2];
List<OrderModel> orderList = [
  OrderModel(id: '1',cartList: cartList, total: 30000, isDone: false),
  OrderModel(id: '2', cartList: cartList2, total: 150000, isDone: true)
];
