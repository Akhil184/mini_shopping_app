import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = mockProducts;

  List<Product> get items => [..._items];

  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);
}
