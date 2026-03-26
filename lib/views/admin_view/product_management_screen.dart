import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/view_models/admin_view_model.dart';
import 'package:provider/provider.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Tất cả';

  static const List<String> _categories = [
    'Tất cả', 'Food', 'Drink', 'Fashion', 'Furniture',
    'Office', 'Accessory', 'Electronic', 'Houseware', 'Other',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminViewModel>(context, listen: false).loadProducts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ProductModel> _filtered(List<ProductModel> products) {
    var list = products;
    if (_selectedCategory != 'Tất cả') {
      list = list.where((p) => p.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((p) => p.name.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  Future<void> _confirmDelete(ProductModel product) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Xóa sản phẩm "${product.name}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Hủy')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      final ok = await Provider.of<AdminViewModel>(context, listen: false)
          .deleteProduct(product.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ok ? 'Đã xóa sản phẩm' : 'Xóa thất bại'),
          backgroundColor: ok ? Colors.green : Colors.red,
        ));
      }
    }
  }

  Future<void> _toggleBlock(ProductModel product) async {
    final vm = Provider.of<AdminViewModel>(context, listen: false);
    final wasBlocked = product.isBlocked;
    final ok = wasBlocked
        ? await vm.unblockProduct(product.id)
        : await vm.blockProduct(product.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ok
            ? (wasBlocked ? 'Đã mở khóa sản phẩm' : 'Đã khóa sản phẩm')
            : 'Thao tác thất bại'),
        backgroundColor: ok ? Colors.green : Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 192, 67),
        title: const Text(
          'Quản lý sản phẩm',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm theo tên sản phẩm...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Category filter chips
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final selected = _selectedCategory == cat;
                return FilterChip(
                  label: Text(cat),
                  selected: selected,
                  onSelected: (_) =>
                      setState(() => _selectedCategory = cat),
                  selectedColor: const Color.fromARGB(255, 233, 192, 67),
                  checkmarkColor: Colors.white,
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<AdminViewModel>(
              builder: (context, vm, _) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final products = _filtered(vm.products);
                if (products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 12),
                        Text('Không có sản phẩm',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16)),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => Provider.of<AdminViewModel>(context,
                          listen: false)
                      .loadProducts(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: products.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, index) => _ProductCard(
                      product: products[index],
                      onDelete: () => _confirmDelete(products[index]),
                      onToggleBlock: () => _toggleBlock(products[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onDelete;
  final VoidCallback onToggleBlock;

  const _ProductCard({
    required this.product,
    required this.onDelete,
    required this.onToggleBlock,
  });

  @override
  Widget build(BuildContext context) {
    final isBlocked = product.isBlocked;
    final price = product.variants.isNotEmpty
        ? '${product.variants[0].price} VND'
        : 'N/A';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // Product icon / image placeholder
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isBlocked ? Colors.red[50] : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 30,
                color: isBlocked ? Colors.red[300] : Colors.grey[500],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isBlocked ? Colors.red : Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isBlocked ? 'Đã khóa' : 'Hiển thị',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Danh mục: ${product.category}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Row(
                    children: [
                      Text(price,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 12),
                      Text('Đã bán: ${product.sold}',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                IconButton(
                  tooltip: isBlocked ? 'Mở khóa sản phẩm' : 'Khóa sản phẩm',
                  onPressed: onToggleBlock,
                  icon: Icon(
                    isBlocked ? Icons.lock_open : Icons.lock,
                    color: isBlocked ? Colors.green : Colors.orange,
                  ),
                ),
                IconButton(
                  tooltip: 'Xóa sản phẩm',
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
