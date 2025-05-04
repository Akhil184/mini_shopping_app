import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../widgets/product_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products = productData.items;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white, // optional: to make blue text visible
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text('Shop',style:TextStyle(color:Colors.blue,fontWeight: FontWeight.bold,),textAlign:TextAlign.center,),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductTile(product: products[i]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
