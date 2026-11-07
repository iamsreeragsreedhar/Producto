import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/feature/product_screens/model/products_model.dart';

class ProductLocalStorage {
  static const String _productsKey = 'cached_products';

  Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = products.map((e) => e.toJson()).toList();
    await prefs.setString(_productsKey, jsonEncode(jsonList));
  }

  Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_productsKey);
    if (cachedData == null) return [];
    final List<dynamic> decoded = jsonDecode(cachedData);
    return decoded.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
  }
}
