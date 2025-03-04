class Review {
  late String userId;
  late String productId;
  late String orderId;
  late String content;
  late double rate;
  late String date;

  Review({
    required this.userId,
    required this.productId,
    required this.orderId,
    required this.content,
    required this.rate,
    required this.date,
  });

  Review.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    productId = json['productId'];
    orderId = json['orderId'];
    content = json['content'];
    rate = (json['rate'] is int)
        ? (json['rate'] as int).toDouble()
        : (json['rate'] as double);
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> review = new Map<String, dynamic>();
    review['userId'] = this.userId;
    review['productId'] = this.productId;
    review['orderId'] = this.orderId;
    review['content'] = this.content;
    review['rate'] = this.rate;
    review['date'] = this.date;
    return review;
  }
}
