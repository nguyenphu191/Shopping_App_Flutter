import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/models/product.dart';

ProductModel banhmithitnuong = ProductModel(
    name: 'Bánh mì thịt nướng',
    price: 20000,
    img: 'assets/image/banhmi.png',
    description:
        'Bánh mì thịt nướng là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ thịt nướng, rau sống, nước mắm, tương ớt, và bánh mì.',
    location: '');
ProductModel bunbohue = ProductModel(
    name: 'Bún bò huế',
    price: 30000,
    description:
        'Bún bò Huế là một món ăn truyền thống nổi tiếng của miền Trung Việt Nam, đặc biệt là từ thành phố Huế. Món này thường được chế biến từ bún (bún là loại bún mì), thịt bò, huyết heo, hành, ngò, rau sống và gia vị.Cách chế biến bún bò Huế bao gồm việc nấu nước dùng từ xương bò và thịt bò, sau đó thêm các loại gia vị như ớt, bột nêm, mắm ruốc để tạo ra hương vị đặc trưng của món ăn này. Bún bò Huế thường được phục vụ nóng, kèm theo rau sống, giá, hành, ngò và chanh để tạo ra hương vị đặc trưng và thơm ngon.Bún bò Huế có hương vị đậm đà, cay nồng, thơm ngon và rất phổ biến trong ẩm thực Việt Nam.',
    img: 'assets/image/food0.png',
    location: '');
ProductModel bunrieu = ProductModel(
    name: 'Bún riêu',
    price: 25000,
    description:
        'Bún riêu là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ bún, nước dùng từ cua, cà chua, rau sống, mắm tôm, và các loại gia vị khác.',
    img: 'assets/image/food1.png',
    location: '');
ProductModel comtam = ProductModel(
    name: 'Cơm tấm',
    price: 25000,
    description:
        'Cơm tấm là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ cơm, thịt nướng, trứng, rau sống, nước mắm, tương ớt, và các loại gia vị khác.',
    img: 'assets/image/food11.png',
    location: '');
ProductModel nemnuong = ProductModel(
    name: 'Nem nướng',
    price: 25000,
    description:
        'Nem nướng là một món ăn phổ biến của người Việt Nam. Món ăn này thường được chế biến từ thịt nướng, bún, rau sống, nước mắm, tương ớt, và các loại gia vị khác.',
    img: 'assets/image/nemnuong.jpg',
    location: '');

List<ProductModel> productList = [
  banhmithitnuong,
  bunbohue,
  bunrieu,
  comtam,
  nemnuong
];

List<CartItem> cartList = [
  // CartItem(product: banhmithitnuong, quantity: 1),
  // CartItem(product: bunbohue, quantity: 1),
  // CartItem(product: bunrieu, quantity: 1),
  // CartItem(product: comtam, quantity: 1),
  // CartItem(product: nemnuong, quantity: 1),
];
