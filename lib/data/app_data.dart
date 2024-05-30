import 'package:flutter_shopping_app/models/Admin.dart';
import 'package:flutter_shopping_app/models/OrderModel.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/models/product.dart';

ProductModel banhmithitnuong = ProductModel(
    id: 1,
    name: 'Bánh mì thịt nướng',
    price: 20000,
    img: 'assets/image/banhmi.png',
    description:
        'Bánh mì thịt nướng là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ thịt nướng, rau sống, nước mắm, tương ớt, và bánh mì.',
    location: 'Hà Nội',
    sold: 0);
ProductModel bunbohue = ProductModel(
    id: 2,
    name: 'Bún bò huế',
    price: 30000,
    description:
        'Bún bò Huế là một món ăn truyền thống nổi tiếng của miền Trung Việt Nam, đặc biệt là từ thành phố Huế. Món này thường được chế biến từ bún (bún là loại bún mì), thịt bò, huyết heo, hành, ngò, rau sống và gia vị.Cách chế biến bún bò Huế bao gồm việc nấu nước dùng từ xương bò và thịt bò, sau đó thêm các loại gia vị như ớt, bột nêm, mắm ruốc để tạo ra hương vị đặc trưng của món ăn này. Bún bò Huế thường được phục vụ nóng, kèm theo rau sống, giá, hành, ngò và chanh để tạo ra hương vị đặc trưng và thơm ngon.Bún bò Huế có hương vị đậm đà, cay nồng, thơm ngon và rất phổ biến trong ẩm thực Việt Nam.',
    img: 'assets/image/bun_bo_hue.jpg',
    location: 'Huế',
    sold: 0);
ProductModel bunrieu = ProductModel(
    id: 3,
    name: 'Bún riêu',
    price: 25000,
    description:
        'Bún riêu là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ bún, nước dùng từ cua, cà chua, rau sống, mắm tôm, và các loại gia vị khác.',
    img: 'assets/image/bun_rieu.jpg',
    location: 'Hải Phòng',
    sold: 0);
ProductModel comtam = ProductModel(
    id: 4,
    name: 'Cơm tấm',
    price: 25000,
    description:
        'Cơm tấm là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ cơm, thịt nướng, trứng, rau sống, nước mắm, tương ớt, và các loại gia vị khác.',
    img: 'assets/image/com_tam.jpg',
    location: 'Hà Nội',
    sold: 0);
ProductModel nemnuong = ProductModel(
    id: 5,
    name: 'Nem nướng',
    price: 25000,
    description:
        'Nem nướng là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ thịt nướng, bún, rau sống, nước mắm, tương ớt, và các loại gia vị khác.',
    img: 'assets/image/nemnuong.jpg',
    location: 'Hải Dương',
    sold: 0);
ProductModel mucrim = ProductModel(
    id: 6,
    name: 'Mực rim cay',
    price: 50000,
    description:
        "Mực rim cay là một món ăn phổ biến trong ẩm thực Việt Nam. Món ăn này được làm từ mực tươi, được chế biến bằng cách rim cùng với các loại gia vị và nước sốt cay nồng. Mực thường được xào nhanh trong dầu nóng với tỏi, ớt và các loại gia vị khác như tiêu, muối, đường và nước mắm để tạo ra hương vị đậm đà và cay nồng. ",
    img: 'assets/image/mucongdim.jpg',
    location: 'Hà Nội',
    sold: 0);
ProductModel raumuong = ProductModel(
    id: 7,
    name: 'Rau muống xào tỏi',
    price: 20000,
    description:
        "Rau muống xào tỏi là một món ăn phổ biến trong ẩm thực Việt Nam. Rau muống được xào nhanh chóng trong dầu nóng với tỏi băm nhỏ cho đến khi chúng mềm nhưng vẫn giữ được độ tươi ngon và màu xanh tươi. Món ăn này thường được gia vị với muối, tiêu và nước mắm để tạo ra hương vị đậm đà. Rau muống xào tỏi thường được dùng kèm với cơm trắng nóng hổi hoặc là một phần của bữa ăn chính. ",
    img: 'assets/image/raumuongxao.jpg',
    location: 'Hà Nội',
    sold: 0);
ProductModel sushi = ProductModel(
    id: 8,
    name: 'Sushi cá hồi',
    price: 60000,
    description:
        "Sushi cá hồi là một món sushi được làm từ miếng cá hồi tươi ngon, được cắt thành lát mỏng và đặt lên trên cơm sushi. Cá hồi thường có màu hồng đậm và có hương vị đặc trưng, ngọt ngon và béo. Món sushi cá hồi thường được phục vụ với một ít wasabi, gừng đỏ và sốt đậu nành. ",
    img: 'assets/image/sushi.jpg',
    location: 'Hà Nội',
    sold: 0);
ProductModel sp0 = ProductModel(
    id: 0, name: '', price: 0, description: '', img: '', location: '', sold: 0);
CartItem it0 = CartItem(product: sp0, quantity: 0);
List<ProductModel> productList = [
  banhmithitnuong,
  bunbohue,
  bunrieu,
  comtam,
  nemnuong,
  mucrim,
  raumuong,
  sushi
];
List<ProductModel> searchList = [];
List<CartItem> cartList = [
  it0,
  // CartItem(product: bunbohue, quantity: 1),
  // CartItem(product: bunrieu, quantity: 1),
  // CartItem(product: comtam, quantity: 1),
  // CartItem(product: nemnuong, quantity: 1),
];
List<CartItem> cartList1 = [
  it0,
  CartItem(product: banhmithitnuong, quantity: 1),
  CartItem(product: bunbohue, quantity: 1),
  CartItem(product: bunrieu, quantity: 1),
  // CartItem(product: comtam, quantity: 1),
  // CartItem(product: nemnuong, quantity: 1),
];
List<CartItem> cartList2 = [
  it0,
  CartItem(product: banhmithitnuong, quantity: 1),
  CartItem(product: bunbohue, quantity: 1),
  CartItem(product: bunrieu, quantity: 1),
  CartItem(product: comtam, quantity: 1),
  CartItem(product: nemnuong, quantity: 1),
];
var total2 = 0;
OrderModel order1 = OrderModel(
  id: '1',
  cartList: cartList1,
  total: 100000,
  isDone: true,
  date: "2021-10-10",
  reciever: "Phú",
  userName: "phu",
  address: "Ha Dong-Hà Nội",
  phone: "1234567890",
  dateComplete: "2021-10-11",
);
User adminn = User(
  username: "",
  email: "",
  phone: "",
  password: "",
  city: "",
  productList: [],
  cartList: [it0],
  orderList: [],
);
User user1 = User(
  username: "phu",
  email: "phu19@gmail.com",
  phone: "1234567890",
  password: "123456",
  city: "Hà Nội",
  productList: [],
  cartList: [it0],
  orderList: [],
);
User user2 = User(
  username: "phuong",
  email: "phuong85@gmail.com",
  phone: "9876543210",
  password: "123456",
  city: "Hải Phòng",
  productList: [],
  cartList: [it0],
  orderList: [],
);
User user3 = User(
  username: "NGAN",
  email: "ngan15@gmail.com",
  phone: "0861602516",
  password: "123456",
  city: "Hà Nội",
  productList: [],
  cartList: [it0],
  orderList: [],
);
User user4 = User(
  username: "dung",
  email: "dung03@gmail.com",
  phone: "0366532366",
  password: "123456",
  city: "Hà Nội",
  productList: [],
  cartList: [it0],
  orderList: [],
);

List<OrderModel> orderList = [];
List<User> userList = [user1, user2, user3, user4];
// List<OrderModel> orderList = [
//   OrderModel(id: '1', cartList: cartList1, total: 100000, isDone: false,),
//   OrderModel(id: '2', cartList: cartList2, total: 150000, isDone: true)
// ];
Admin admin = Admin(
    adName: "admin@123",
    adPass: "123456",
    userList: userList,
    productList: productList,
    orderList: orderList);
