import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Make sure you are correctly navigating to the ProductDetailScreen
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName, // Ensure the route name is correct
          arguments: product.id, // Passing the product id to the details screen
        );
      },
      child: Material(
        color: Colors.transparent, // Transparent material to show card background
        child: Card(
          elevation: 5, // Initial elevation
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            splashColor: Colors.blue.withOpacity(0.3), // Optional splash effect
            highlightColor: Colors.blue.withOpacity(0.1), // Optional highlight effect
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      product.imageUrl, // Use asset image as previously set up
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
