import 'package:e_commerce_new/models/product_model.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key, required this.products});
  final List<Product> products;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: widget.products.isEmpty
          ? const Center(
        child: Text(
          "Your cart is empty",
          style: TextStyle(fontSize: 20),
        ),
      )
          : ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text("\$${product.price}"),
            leading: Image.network(product.imageUrl, width: 50, height: 50),
            trailing: TextButton(
              onPressed: () {
                setState(() {
                  widget.products.removeAt(index);
                });
              },
              child: const Text(
                "Remove from Cart",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          );
        },
      ),
    );
  }
}
