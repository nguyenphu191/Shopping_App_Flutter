import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/order.dart';
import 'package:flutter_shopping_app/models/user.dart';
import 'package:flutter_shopping_app/view_models/order_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SellerOrderDetailScreen extends StatefulWidget {
  final OrderModel order;
  final User seller;

  const SellerOrderDetailScreen({
    super.key,
    required this.order,
    required this.seller,
  });

  @override
  State<SellerOrderDetailScreen> createState() => _SellerOrderDetailScreenState();
}

class _SellerOrderDetailScreenState extends State<SellerOrderDetailScreen> {
  Future<void> _confirmOrder() async {
    final orderVM = Provider.of<OrderViewModel>(context, listen: false);
    final result = await orderVM.updateOrderBySeller(widget.order.id, 'delivering');
    if (!mounted) return;
    if (result['status'] == 'success') {
      setState(() => widget.order.status = 'delivering');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã xác nhận đơn hàng, chuyển sang đang giao'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Xác nhận thất bại, thử lại'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
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
                        'Chi tiết đơn hàng',
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
              // Content
              Expanded(
                child: Consumer<OrderViewModel>(
                  builder: (context, orderVM, _) {
                    if (orderVM.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildStatusCard(),
                          const SizedBox(height: 12),
                          _buildDeliveryInfoCard(),
                          const SizedBox(height: 12),
                          _buildItemsCard(),
                          const SizedBox(height: 12),
                          _buildPaymentCard(),
                          const SizedBox(height: 20),
                          _buildActionButton(),
                          const SizedBox(height: 16),
                        ],
                      ),
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

  Widget _buildStatusCard() {
    final shortId = widget.order.id.length > 8
        ? widget.order.id.substring(widget.order.id.length - 8)
        : widget.order.id;
    final statusLabel = _getStatusLabel(widget.order.status);
    final statusColor = _getStatusColor(widget.order.status);

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Đơn hàng #$shortId',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Ngày đặt: ${widget.order.time}',
              style: TextStyle(fontSize: 13, color: Colors.grey[700])),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: statusColor),
            ),
            child: Text(
              statusLabel,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfoCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Thông tin giao hàng',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _infoRow(Icons.person, 'Người nhận', widget.order.reciever),
          _infoRow(Icons.phone, 'Số điện thoại', widget.order.phone),
          _infoRow(Icons.location_on, 'Địa chỉ', widget.order.address),
        ],
      ),
    );
  }

  Widget _buildItemsCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sản phẩm (${widget.order.cartList.length})',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...widget.order.cartList.map((item) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.product.name,
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text('Màu: ${item.color}  •  Size: ${item.size}',
                              style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('x${item.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('${item.price.toStringAsFixed(0)}đ',
                            style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPaymentCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Thanh toán',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Phương thức:', style: TextStyle(fontSize: 13)),
              Text(widget.order.methodPayment,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Trạng thái TT:', style: TextStyle(fontSize: 13)),
              Text(
                widget.order.isPaymented ? 'Đã thanh toán' : 'Chưa thanh toán',
                style: TextStyle(
                  fontSize: 13,
                  color: widget.order.isPaymented ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tổng tiền:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                '${widget.order.total.toStringAsFixed(0)}đ',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    if (widget.order.status == 'pendingseller') {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: _confirmOrder,
          icon: const Icon(Icons.check_circle_outline),
          label: const Text('Xác nhận đơn',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 39, 195, 174),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text('$label: ', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
        ],
      ),
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'pendingseller': return 'Chờ xác nhận';
      case 'delivering':    return 'Đang giao';
      case 'delivered':     return 'Đã giao';
      case 'cancelled':     return 'Đã hủy';
      default:              return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pendingseller': return Colors.orange;
      case 'delivering':    return Colors.blue;
      case 'delivered':     return Colors.green;
      case 'cancelled':     return Colors.red;
      default:              return Colors.grey;
    }
  }
}
