import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_new/models/product_model.dart';
import 'package:e_commerce_new/screens/components/cart.dart';
import 'package:e_commerce_new/screens/components/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Product> cart = [];

  static final List<Product> kProducts = [
    Product(
      name: 'Product 1',
      price: 100.0,
      imageUrl:
          'https://assets.adidas.com/images/w_940,f_auto,q_auto/038692973e594495a5966d3ba81af3b7_9366/JK2250_21_model.jpg',
      id: '1',
      rating: 4.7,
    ),
    Product(
      name: 'Product 2',
      price: 200.0,
      imageUrl:
          'https://assets.adidas.com/images/w_940,f_auto,q_auto/038692973e594495a5966d3ba81af3b7_9366/JK2250_21_model.jpg',
      id: '2',
      rating: 4,
    ),
    Product(
      name: 'Product 3',
      price: 300.0,
      imageUrl:
          'https://assets.adidas.com/images/w_940,f_auto,q_auto/038692973e594495a5966d3ba81af3b7_9366/JK2250_21_model.jpg',
      id: '3',
      rating: 4.5,
    ),
    Product(
      name: 'Product 4',
      price: 400.0,
      imageUrl:
          'https://assets.adidas.com/images/w_940,f_auto,q_auto/038692973e594495a5966d3ba81af3b7_9366/JK2250_21_model.jpg',
      id: '4',
      rating: 4.8,
    ),
    Product(
      name: 'Product 5',
      price: 500.0,
      imageUrl:
          'https://assets.adidas.com/images/w_940,f_auto,q_auto/038692973e594495a5966d3ba81af3b7_9366/JK2250_21_model.jpg',
      id: '5',
      rating: 4.9,
    ),
    Product(
      name: 'Product 6',
      price: 600.0,
      imageUrl:
          'https://assets.adidas.com/images/w_940,f_auto,q_auto/038692973e594495a5966d3ba81af3b7_9366/JK2250_21_model.jpg',
      id: '6',
      rating: 4.6,
    ),
    Product(
      name: 'Product 7',
      price: 700.0,
      imageUrl:
          'https://assets.adidas.com/images/w_940,f_auto,q_auto/038692973e594495a5966d3ba81af3b7_9366/JK2250_21_model.jpg',
      id: '7',
      rating: 4.3,
    ),
  ];
  List<String> appBarText = ["welcome to my store", " profile", "cart"];

  int selectedIndex = 0;

  void _toggleCart(Product product) async {
    try {
      await FirebaseFirestore.instance
          .collection("cart")
          .doc(product.id)
          .set({
        "id": product.id,
        "name": product.name,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "rating": product.rating,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${product.name} added to cart")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error adding to cart: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _homeBody(context),
      const ProfilePage(),
      Cart(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(appBarText[selectedIndex]), centerTitle: true),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: selectedIndex == 0 ? Colors.blue : null,
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 1 ? Colors.blue : null,
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: selectedIndex == 2 ? Colors.blue : null,
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

 ListView _homeBody(BuildContext context) {
    return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: kProducts.length,
            itemBuilder: (_, i) {
              final p = kProducts[i];
              return productTile(
                context: context,
                product: p,
                onCart: () => _toggleCart(p),
              );
            },
          );

  }
}

Widget productTile({
  required BuildContext context,
  required Product product,
  required VoidCallback onCart,
}) {
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          product.imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(product.name),
      subtitle: Text("Price: ${product.price} EGP"),
      trailing: TextButton(
        onPressed: onCart,
        child: Text("Add to Cart", style: TextStyle(color: Colors.blue)),
      ),
    ),
  );
}

Widget _welcomeMessage(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  return Text(
    "Welcome, ${user?.displayName}!",
    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );
}
