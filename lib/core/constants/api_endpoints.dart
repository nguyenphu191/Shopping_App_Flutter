class ApiEndpoints {
  ApiEndpoints._();

  // Users
  static const String login = '/users/login';
  static const String register = '/users/register';
  static const String getUser = '/users/getuser';
  static const String updateUser = '/users/update';
  static const String deleteUser = '/users/delete';

  // Products
  static const String addProduct = '/products/addproduct';
  static const String getProducts = '/products/getproducts';
  static const String getPopular = '/products/getpopular';
  static const String getProduct = '/products/getproduct';
  static const String updateProduct = '/products/updateproduct';
  static const String searchProduct = '/products/searchproduct';
  static const String deleteProduct = '/products/deleteproduct';

  // Wallet
  static const String deductBalance = '/users/deductbalance';
  static const String addBalance = '/users/addbalance';
  static const String adminAddBalance = '/admin/addbalance';

  // Cart
  static const String addToCart = '/carts/addtocart';
  static const String getCart = '/carts/getcart';
  static const String updateCart = '/carts/updatecart';
  static const String deleteCart = '/carts/deletecart';

  // Orders
  static const String getInfor = '/orders/getInfor';
  static const String createOrder = '/orders/create';
  static const String getOrder = '/orders/get';
  static const String updateOrder = '/orders/update';
  static const String getSellerOrders = '/orders/seller';
  static const String updateOrderBySeller = '/orders/seller/update';
  static const String getOrderById = '/orders/getorderbyid';

  // Wishlist
  static const String wishlistAdd = '/wishlist/add';
  static const String wishlistRemove = '/wishlist/remove';
  static const String wishlistGet = '/wishlist/get';
  static const String wishlistCheck = '/wishlist/check';

  // Admin
  static const String adminStats = '/admin/stats';
  static const String adminPendingOrders = '/admin/orders/pending';
  static const String adminApproveOrder = '/admin/orders/approve';
  static const String adminRejectOrder = '/admin/orders/reject';
  static const String adminGetUsers = '/admin/users';
  static const String adminDeleteUser = '/admin/users';
  static const String adminBlockUser = '/admin/users/block';
  static const String adminUnblockUser = '/admin/users/unblock';
  static const String adminGetProducts = '/admin/products';
  static const String adminDeleteProduct = '/admin/products';
  static const String adminBlockProduct = '/admin/products/block';
  static const String adminUnblockProduct = '/admin/products/unblock';

  // Reviews
  static const String addReview = '/reviews/addreview';
  static const String getReviews = '/reviews/getreviews';
  static const String getReview = '/reviews/getreview';
}
