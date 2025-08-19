import 'package:e_commerce_new/models/product_model.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key, required this.products});
  final List <Product> products ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
        body: Center(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
           return ListTile(
          title: Text(product.name),
          subtitle: Text("\$${product.price}"),
          leading: Image.network(product.imageUrl, width: 50, height: 50),
          );
        },

        ),
      ),
        );
  }
}