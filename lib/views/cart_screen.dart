import 'package:day4/components/mini_tile.dart';
import 'package:day4/models/product_modal.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<ProductModel> products;
  final Set<int> cardIds;

  const CartScreen({super.key, required this.cardIds, required this.products});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
        .where((product) => widget.cardIds.contains(product.id))
        .toList();

    double totalPrice = 0;

    for (var product in cartProducts) {
      totalPrice += product.price;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: cartProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 60,
                              color: Color(0xFF4F46E5),
                            ),
                          ),

                          const SizedBox(height: 30),

                          const Text(
                            "Your cart is empty",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            "Looks like you haven't added\nany products yet.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: 220,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: cartProducts.isEmpty
                                  ? null
                                  : () {
                                      Navigator.pop(context);
                                    },
                              icon: const Icon(Icons.shopping_bag_outlined),
                              label: const Text("Continue Shopping"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4F46E5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        final product = cartProducts[index];

                        return MiniCardTile(
                          name: product.title,
                          tagline: product.category,
                          price: "\$${product.price}",
                          imageUrl: product.image,
                          onRemove: () {
                            setState(() {
                              widget.cardIds.remove(product.id);
                            });
                          },
                        );
                      },
                    ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  widget.cardIds.clear();
                });
              },
              icon: const Icon(Icons.delete_outline),
              label: const Text("Clear Cart"),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                if (cartProducts.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Row(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 10),
                            Text("Cart is Empty"),
                          ],
                        ),
                        content: const Text(
                          "Please add at least one product before proceeding to checkout.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );

                  return;
                }

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 10),
                          Text("Order Completed"),
                        ],
                      ),

                      content: const Text("Thank you for your purchase!"),

                      actions: [
                        TextButton(
                          onPressed: () {
                            widget.cardIds.clear();
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),

              child: const Text(
                "Checkout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
