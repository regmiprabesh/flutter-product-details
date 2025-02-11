import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:product_description/app/data/models/product_model.dart';
import 'package:product_description/config.dart';

class ProductProvider {
  Future<Product> getProductDetails(String slug) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/product/for-public/$slug'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Product.fromJson(data['data']);
      } else {
        throw Exception('Failed to load product data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
