import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/order.dart';
import 'package:flutter_shopping_app/models/user.dart';
import 'package:flutter_shopping_app/view_models/order_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SellerOrderListScreen extends StatefulWidget {
  final User seller;
  final String initialStatus;

  const SellerOrderListScreen({
    super.key,
    required this.seller,
    required this.initialStatus,
  });

  @override
  State<SellerOrderListScreen> createState() => _SellerOrderListScreenState();
}

class _SellerOrderListScreenState extends State<SellerOrderListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = ['pendingseller', 'delivering', 'delivered'];

  @override
  void initState() {
    super.initState();
    final initialIndex = _tabs.indexOf(widget.initialStatus).clamp(0, 2);
    _tabController = TabController(length: 3, vsync: this, initialIndex: initialIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderViewModel>(context, listen: false)
          .getSellerOrders(widget.seller.id);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 177, 234, 161),
                Color.fromARGB(255, 241, 152, 198),
                Color.fromARGB(255, 112, 160, 238),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                height: 60,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 68, 142, 240),
                      Color.fromARGB(255, 39, 195, 174),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                    const Expanded(
                      child: Text(
                        'Quản lý đơn hàng',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              // Tab bar
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  labelColor: const Color.fromARGB(255, 47, 120, 246),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color.fromARGB(255, 36, 116, 255),
                  tabs: const [
                    Tab(text: 'Đơn hàng mới'),
                    Tab(text: 'Đang giao'),
                    Tab(text: 'Đã giao'),
                  ],
                ),
              ),
              // Tab content
              Expanded(
                child: Consumer<OrderViewModel>(
                  builder: (context, orderVM, _) {
                    if (orderVM.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return TabBarView(
                      controller: _tabController,
                      children: _tabs
                          .map((status) => _buildOrderList(context, orderVM, status))
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, OrderViewModel orderVM, String status) {
    final filtered = orderVM.sellerOrders.where((o) => o.status == status).toList();

    return RefreshIndicator(
      onRefresh: () => orderVM.getSellerOrders(widget.seller.id),
      child: filtered.isEmpty
          ? ListView(
              children: const [
                SizedBox(height: 100),
                Center(child: Text('Không có đơn hàng', style: TextStyle(fontSize: 16))),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: filtered.length,
              itemBuilder: (context, index) => _buildOrderCard(context, filtered[index]),
            ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    final shortId = order.id.length > 8 ? order.id.substring(order.id.length - 8) : order.id;
    final dateDisplay = order.time.length >= 10 ? order.time.substring(0, 10) : order.time;

    return GestureDetector(
      onTap: () => context.push('/seller/order-detail', extra: {
        'order': order,
        'seller': widget.seller,
      }),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đơn #$shortId',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Người nhận: ${order.reciever}', style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(
                    '${order.cartList.length} sản phẩm  •  ${order.total.toStringAsFixed(0)}đ',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ngày đặt: $dateDisplay',
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
