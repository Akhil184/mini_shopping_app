import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}')),
                  TextButton(
                    onPressed: cart.clear,
                    child: Text('Clear Cart'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) {
                final cartItem = cart.items.values.toList()[i];
                return ListTile(
                  title: Text(cartItem.title),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  trailing: Text('\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
