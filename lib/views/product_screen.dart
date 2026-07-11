import 'package:day4/components/product_tile.dart';
import 'package:day4/models/product_modal.dart';
import 'package:day4/services/api_service.dart';
import 'package:day4/services/local_storage.dart';
import 'package:day4/views/cart_screen.dart';
import 'package:day4/views/login_screen.dart';
import 'package:day4/views/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ApiService apiService = ApiService();
  final LocalStorageServices storage = LocalStorageServices();

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  final Set<int> cardIds = {};

  bool isLoading = false;
  String errorMessage = "";
  String username = "";

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProducts();
    loadUsername();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadUsername() async {
    final data = await storage.getData();

    if (!mounted) return;

    setState(() {
      username = data ?? "";
    });
  }

  Future<void> loadProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      final result = await apiService.fetchProducts();

      setState(() {
        allProducts = result;
        filteredProducts = List.from(result);
      });
    } catch (e) {
      setState(() {
        errorMessage = "Products could not be loaded.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchProduct(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        filteredProducts = List.from(allProducts);
      });
      return;
    }

    setState(() {
      filteredProducts = allProducts.where((product) {
        return product.title.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  Future<void> logout() async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 10),
              Text("Logout"),
            ],
          ),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (result != true) return;

    await storage.clearData();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void openProfileMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 36,
                  child: Icon(Icons.person, size: 38),
                ),

                const SizedBox(height: 16),

                Text(
                  username.isEmpty ? "Guest" : username,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text("Logout"),
                  onTap: logout,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome 👋",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Discover Products",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CartScreen(
                                    cardIds: cardIds,
                                    products: allProducts,
                                  ),
                                ),
                              ).then((_) {
                                setState(() {});
                              });
                            },
                          ),

                          if (cardIds.isNotEmpty)
                            Positioned(
                              right: 4,
                              top: 4,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${cardIds.length}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      IconButton(
                        icon: const Icon(Icons.person_outline),
                        iconSize: 30,
                        onPressed: openProfileMenu,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                "Find your perfect device.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: searchController,
                onChanged: searchProduct,
                decoration: InputDecoration(
                  hintText: "Search products",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      searchProduct("");
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                ),
              ),

              const SizedBox(height: 16),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://wantapi.com/assets/banner.png",
                  width: double.infinity,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular Products",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${filteredProducts.length} Items",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              const SizedBox(height: 16),

              if (isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (errorMessage.isNotEmpty)
                Expanded(child: Center(child: Text(errorMessage)))
              else
                Expanded(
                  child: RefreshIndicator(
                    color: const Color(0xFF4F46E5),
                    onRefresh: loadProducts,
                    child: filteredProducts.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 70,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  "No products found",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Try searching with another keyword.",
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            itemCount: filteredProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.55,
                                ),
                            itemBuilder: (context, index) {
                              final product = filteredProducts[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(
                                        product: product,
                                        cardIds: cardIds,
                                      ),
                                    ),
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                child: ProductTile(product: product),
                              );
                            },
                          ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
