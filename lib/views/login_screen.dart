import 'package:day4/services/local_storage.dart';
import 'package:day4/views/product_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final LocalStorageServices localStorageServices = LocalStorageServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 70,
                  color: Color(0xFF4F46E5),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Welcome Back 👋",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  "Sign in to continue shopping",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),

                const SizedBox(height: 35),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30),

                TextFormField(
                  controller: surnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Surname",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your surname';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        color: Color(0xFF4F46E5),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Secure Login\nYour information is stored safely.",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await localStorageServices.saveData(nameController.text);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Login", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
