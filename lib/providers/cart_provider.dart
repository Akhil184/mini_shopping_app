import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {}; // ✅ This must exist!

  Map<String, CartItem> get items => {..._items};

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, double price, int quantity) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          quantity: existing.quantity + quantity,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
            () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
            (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          quantity: existing.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
