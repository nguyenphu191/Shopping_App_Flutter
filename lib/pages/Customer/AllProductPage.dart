import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/Product.dart';
import 'package:flutter_shopping_app/pages/Customer/CartPage.dart';
import 'package:flutter_shopping_app/pages/Customer/HomePage.dart';
import 'package:flutter_shopping_app/pages/Customer/OrderListPage.dart';
import 'package:flutter_shopping_app/pages/DetailProduct.dart';
import 'package:flutter_shopping_app/pages/ProfilePage.dart';
import 'package:flutter_shopping_app/provider/AuthProvider.dart';
import 'package:flutter_shopping_app/provider/ProductProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({Key? key}) : super(key: key);
  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage>
    with SingleTickerProviderStateMixin {
  List<ProductModel> _allProducts = [];

  final List<String> _categories = [
    "All",
    "Food",
    "Drink",
    "Fashion",
    "Furniture",
    "Office",
    "Accessory",
    "Electronic",
    "Houseware",
    "Other"
  ];
  String _selectedCategory = "All";
  List<ProductModel> _filteredProducts = [];

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isFilterOpen = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);

      productProvider.getAllProducts();
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0),
      end: Offset(0.0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _applyFilters() {
    if (_selectedCategory == "All") {
      _filteredProducts = _allProducts;
    } else {
      _filteredProducts = _allProducts
          .where((product) => product.category == _selectedCategory)
          .toList();
    }
  }

  void _toggleFilterPanel() {
    setState(() {
      if (_isFilterOpen) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _isFilterOpen = !_isFilterOpen;
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _applyFilters();
      _toggleFilterPanel(); // Đóng panel sau khi chọn
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 252, 100, 54),
          toolbarHeight: 80,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Danh sách sản phẩm',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: _toggleFilterPanel,
            ),
          ],
          centerTitle: true,
        ),
      ),
      body: Stack(
        children: [
          // Nội dung chính
          Column(
            children: [
              // Thanh tìm kiếm
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm sản phẩm...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchController.text = value;
                    });
                  },
                ),
              ),
              Container(
                height: 10,
                color: Colors.grey[300],
              ),
              Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                if (productProvider.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (productProvider.allproducts.isEmpty) {
                  return Center(
                    child: Text('Không có sản phẩm nào'),
                  );
                }
                _allProducts = productProvider.allproducts;
                if (_searchController.text.isEmpty) {
                  _filteredProducts = _allProducts;
                } else {
                  _filteredProducts = _allProducts
                      .where((product) => product.name
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()))
                      .toList();
                }
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return _buildProductCard(product);
                    },
                  ),
                );
              }),
            ],
          ),
          // Panel bộ lọc
          if (_isFilterOpen)
            GestureDetector(
              onTap: _toggleFilterPanel,
              child: Container(
                color: Colors.black.withOpacity(0.5), // Làm mờ nền
              ),
            ),
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lọc theo danh mục',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    ..._categories.map((category) {
                      return ListTile(
                        title: Text(_getFilterText(category)),
                        onTap: () => _filterByCategory(category),
                      );
                    }).toList(),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: Colors.orange,
        child: FaIcon(
          FontAwesomeIcons.bagShopping,
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 50,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              icon: FaIcon(
                FontAwesomeIcons.home,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                ).then((value) {
                  if (value == true) {
                    setState(() {});
                  }
                });
              },
              icon: FaIcon(
                FontAwesomeIcons.shoppingCart,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderListPage(),
                  ),
                ).then((value) {
                  if (value == true) {
                    setState(() {});
                  }
                });
              },
              icon: FaIcon(
                FontAwesomeIcons.truck,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      user: user!,
                    ),
                  ),
                ).then((value) {
                  if (value == true) {
                    setState(() {}); // Làm mới danh sách sau khi quay lại
                  }
                });
              },
              icon: FaIcon(
                FontAwesomeIcons.user,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProduct(
                productId: product.id,
                role: 'customer',
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color.fromARGB(255, 45, 44, 44),
                width: 1,
              ),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 158,
                  width: double.maxFinite,
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  //   child: Image.network(
                  //     product.img,
                  //     height: 180,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  child: Hero(
                    tag: product.imgs[0],
                    child: Image.asset(
                      "assets/image/banhmi.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tên sản phẩm
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      // Giá sản phẩm

                      Text(
                        '${product.variants[0].price.toString()}VND',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 15),

                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _Stars(product.rating, Colors.black),
                          Text(
                            'Lượt bán: ${product.sold} ',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 20,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  '-${product.variants[0].discount}%',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 0, 0),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Widget _Stars(double rating, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      return Icon(
        index + 1 <= rating
            ? Icons.star // Sao đầy
            : index + 1 - rating < 1
                ? Icons.star_half // Sao nửa
                : Icons.star_border, // Sao rỗng
        color: color, // Màu sao
        size: 10,
      );
    }),
  );
}

String _getFilterText(String type) {
  switch (type) {
    case 'All':
      return 'Tất cả';
    case 'Food':
      return 'Đồ ăn';
    case 'Drink':
      return 'Đồ uống';
    case 'Fashion':
      return 'Thời trang';
    case 'Furniture':
      return 'Nội thất';
    case 'Office':
      return 'Thiết bị văn phòng';

    case 'Accessory':
      return 'Phụ kiện';
    case 'Electronic':
      return 'Thiết bị điện tử';
    case 'Houseware':
      return 'Đồ gia dụng';
    default:
      return 'Khác';
  }
}
