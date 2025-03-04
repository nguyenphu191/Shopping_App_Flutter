import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/Product.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/pages/DetailProduct.dart';

import 'package:flutter_shopping_app/provider/ProductProvider.dart';
import 'package:flutter_shopping_app/provider/UserProvider.dart';
import 'package:provider/provider.dart';

class HomeStorePage extends StatefulWidget {
  final String role;
  final String sellerId;
  const HomeStorePage({super.key, required this.role, required this.sellerId});

  @override
  State<HomeStorePage> createState() => _HomeStorePageState();
}

class _HomeStorePageState extends State<HomeStorePage>
    with TickerProviderStateMixin {
  List<ProductModel> _products = [];
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
  String _searchQuery = "";

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isFilterOpen = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.getUserProducts(widget.sellerId);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.findUserById(widget.sellerId);
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
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products
          .where((product) => product.category == _selectedCategory)
          .toList();
    }
    if (_searchQuery.isNotEmpty) {
      _filteredProducts = _filteredProducts
          .where((product) =>
              product.name.toLowerCase().contains(_searchQuery.toLowerCase()))
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
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
      if (productProvider.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      _products = productProvider.userproducts;
      _filteredProducts = _products;
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 252, 100, 54),
            toolbarHeight: 80,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            title: FutureBuilder<User>(
              future: Provider.of<UserProvider>(context, listen: false)
                  .findUserById(widget.sellerId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Đang tải...');
                }
                if (snapshot.hasError) {
                  return Text('Đã xảy ra lỗi');
                }
                return Text(
                  snapshot.data!.username,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                );
              },
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: _toggleFilterPanel,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm sản phẩm...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    onChanged: (query) {},
                  ),
                ),
                Expanded(
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
                ),
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
      );
    });
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
                role: widget.role,
              ),
            ),
          );
        },
        child: Container(
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hình ảnh sản phẩm
                Container(
                  height: 160,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(5),
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  //   child: Image.network(
                  //     product.img,
                  //     height: 180,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/banhmi.png"),
                      fit: BoxFit.cover,
                    ),
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
