import '../models/product.dart';
import '../models/category.dart';

final List<Product> mockProducts = [
  Product(
    id: 'p1',
    title: 'Running Shoes',
    description: 'Lightweight and breathable running shoes.',
    price: 59.99,
    imageUrl: 'assets/shoes.jpg',
  ),
  Product(
    id: 'p2',
    title: 'Casual T-Shirt',
    description: 'Soft cotton T-shirt for daily wear.',
    price: 19.99,
    imageUrl: 'assets/t_shirt.jpg',
  ),
  Product(
    id: 'p3',
    title: 'Blue Jeans',
    description: 'Comfortable slim-fit denim jeans.',
    price: 39.99,
    imageUrl: 'assets/jeans.jpg',
  ),
  Product(
    id: 'p4',
    title: 'Hooded Sweatshirt',
    description: 'Warm and cozy hoodie for casual wear.',
    price: 49.99,
    imageUrl: 'assets/hoodie.jpg',
  ),
  Product(
    id: 'p5',
    title: 'Baseball Cap',
    description: 'Classic adjustable cap.',
    price: 14.99,
    imageUrl: 'assets/cap.jpg',
  ),
  Product(
    id: 'p6',
    title: 'Backpack',
    description: 'Durable backpack for everyday use.',
    price: 44.99,
    imageUrl: 'assets/backpack.jpg',
  ),
];

final List<Category> mockCategories = [
  Category(id: 'c1', title: 'Footwear'),
  Category(id: 'c2', title: 'Clothing'),
  Category(id: 'c3', title: 'Accessories'),
];
