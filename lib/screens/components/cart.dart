import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_new/models/product_model.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Product> products = [];


  Future<void> getData() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('cart').get();

    final List<Product> loaded = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Product.fromMap(data);
    }).toList();

    setState(() {
      products = loaded;
    });
  }
  Future<void> removeProduct(String productId, int index) async {
    await FirebaseFirestore.instance.collection('cart').doc(productId).delete();

    setState(() {
      products.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: products.isEmpty
          ? const Center(
        child: Text(
          "Your cart is empty",
          style: TextStyle(fontSize: 20),
        ),
      )
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text("\$${product.price}"),
            leading: Image.network(product.imageUrl,
                width: 50, height: 50, fit: BoxFit.cover),
            trailing: TextButton(
              onPressed: () {
                setState(() async{
                  await removeProduct(product.id, index);
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
