import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 0; // Start with quantity 0 (button initially says Add to Cart)
  late Product loadedProduct;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      loadedProduct = Provider.of<ProductProvider>(context, listen: false).findById(productId);
      _isInit = false;
    }
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
      // If item is already in cart, update the quantity, else add it
      Provider.of<CartProvider>(context, listen: false).addItem(
        loadedProduct.id,
        loadedProduct.title,
        loadedProduct.price,
        1,
      );
    });

    _showSnackBar();
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
        Provider.of<CartProvider>(context, listen: false).removeSingleItem(loadedProduct.id);
      });

      _showSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: Column(
        children: [
          // Display the image using local assets
          Image.asset(loadedProduct.imageUrl),
          SizedBox(height: 10),
          // Display the price
          Text('\$${loadedProduct.price}', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          // Display the description
          Text(loadedProduct.description),
          SizedBox(height: 20),

          // Single Container for Add or +- buttons with improved width handling
          Container(
            width: 130, // Ensures the container takes the full width of the screen
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _quantity == 0
            // If quantity is 0, show the Add to Cart button
                ? GestureDetector(
              onTap: () {
                // Add product to cart with quantity 1
                Provider.of<CartProvider>(context, listen: false).addItem(
                  loadedProduct.id,
                  loadedProduct.title,
                  loadedProduct.price,
                  1, // Default quantity is 1
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Added 1 x ${loadedProduct.title} to Cart',
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/cart');
                          },
                          child: Text(
                            'View Cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                setState(() {
                  _quantity = 1; // Update quantity to 1 after adding the product to cart
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            )
            // If quantity is greater than 0, show the +- buttons
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decreaseQuantity,
                  color: Colors.white,
                ),
                // Display the quantity
                Text('$_quantity', style: TextStyle(fontSize: 20, color: Colors.white)),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _increaseQuantity,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        content: Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Updated $_quantity x ${loadedProduct.title}',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
                child: Text(
                  'View Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.white24, width: 1),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
