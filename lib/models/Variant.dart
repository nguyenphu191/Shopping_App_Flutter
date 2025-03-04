class Variant {
  late String color;
  late String size;
  late int stock;
  late double price;
  late int discount;
  Variant(
      {required this.color,
      required this.size,
      required this.stock,
      required this.price,
      required this.discount});
  Variant.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    size = json['size'];
    stock = json['stock'];
    price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : (json['price'] as double);
    discount = json['discount'];
  }
  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'size': size,
      'stock': stock,
      'price': price,
      'discount': discount
    };
  }
}
