import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini Shopping App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
