import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/user.dart';
import 'package:flutter_shopping_app/view_models/admin_view_model.dart';
import 'package:provider/provider.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminViewModel>(context, listen: false).loadUsers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<User> _filtered(List<User> users) {
    if (_searchQuery.isEmpty) return users;
    final q = _searchQuery.toLowerCase();
    return users
        .where((u) =>
            u.username.toLowerCase().contains(q) ||
            u.email.toLowerCase().contains(q))
        .toList();
  }

  Future<void> _confirmDelete(User user) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Xóa tài khoản "${user.username}"?'),
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
          .deleteUser(user.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ok ? 'Đã xóa tài khoản' : 'Xóa thất bại'),
          backgroundColor: ok ? Colors.green : Colors.red,
        ));
      }
    }
  }

  Future<void> _toggleBlock(User user) async {
    final vm = Provider.of<AdminViewModel>(context, listen: false);
    final wasBlocked = user.isBlocked;
    final ok =
        wasBlocked ? await vm.unblockUser(user.id) : await vm.blockUser(user.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ok
            ? (wasBlocked ? 'Đã mở khóa tài khoản' : 'Đã khóa tài khoản')
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
          'Quản lý người dùng',
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
                hintText: 'Tìm theo tên hoặc email...',
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
      body: Consumer<AdminViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = _filtered(vm.users);
          if (users.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  Text('Không có người dùng',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                Provider.of<AdminViewModel>(context, listen: false).loadUsers(),
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: users.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, index) => _UserCard(
                user: users[index],
                onDelete: () => _confirmDelete(users[index]),
                onToggleBlock: () => _toggleBlock(users[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onDelete;
  final VoidCallback onToggleBlock;

  const _UserCard({
    required this.user,
    required this.onDelete,
    required this.onToggleBlock,
  });

  @override
  Widget build(BuildContext context) {
    final isBlocked = user.isBlocked;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: isBlocked ? Colors.red[100] : Colors.blue[100],
              child: Icon(
                Icons.person,
                size: 30,
                color: isBlocked ? Colors.red : Colors.blue,
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
                          user.username,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
                          isBlocked ? 'Đã khóa' : 'Hoạt động',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(user.email,
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis),
                  Text(user.phone,
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey[600])),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                IconButton(
                  tooltip: isBlocked ? 'Mở khóa' : 'Khóa tài khoản',
                  onPressed: onToggleBlock,
                  icon: Icon(
                    isBlocked ? Icons.lock_open : Icons.lock,
                    color: isBlocked ? Colors.green : Colors.orange,
                  ),
                ),
                IconButton(
                  tooltip: 'Xóa tài khoản',
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
