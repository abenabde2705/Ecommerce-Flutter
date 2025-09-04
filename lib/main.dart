import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/product_page.dart';
import 'presentation/pages/cart_page.dart';
import 'presentation/viewmodels/cart_viewmodel.dart';
import 'data/repositories/cart_repository_impl.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartViewModel(repository: CartRepositoryImpl()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Flutter',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const ProductPage(productId: 1), // pour tester direct
    );
  }
}
