import 'package:flutter/material.dart';

class VariantProvider with ChangeNotifier {
  int _color = 0;
  int _size = 0;
  int _quantity = 1;

  int get color => _color;
  int get size => _size;
  int get quantity => _quantity;

  void reset() {
    _color = 0;
    _size = 0;
    _quantity = 1;
    notifyListeners();
  }

  void setColor(int index) {
    _color = index;
    notifyListeners();
  }

  void setSize(int index) {
    _size = index;
    notifyListeners();
  }

  void increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
    }
    notifyListeners();
  }
}
