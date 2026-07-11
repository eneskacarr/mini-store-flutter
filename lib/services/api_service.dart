import 'dart:convert';

import 'package:day4/models/product_modal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } else {
      throw Exception("Products could not be loaded.");
    }
  }
}