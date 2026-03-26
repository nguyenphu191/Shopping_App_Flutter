import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final Color color;
  final double size;

  const StarRating({
    super.key,
    required this.rating,
    this.color = Colors.orange,
    this.size = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: color, size: size);
        } else if (index < rating) {
          return Icon(Icons.star_half, color: color, size: size);
        } else {
          return Icon(Icons.star_border, color: color, size: size);
        }
      }),
    );
  }
}
