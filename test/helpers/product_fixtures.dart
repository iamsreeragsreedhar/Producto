import 'package:flutter_application_1/feature/product_screens/model/products_model.dart';

Map<String, dynamic> productJson({int id = 1}) => {
  'id': id,
  'title': 'Test Product $id',
  'description': 'A product used by automated tests.',
  'price': 19.99,
  'discountPercentage': 10.0,
  'rating': 4.5,
  'stock': 12,
  'brand': 'Producto Test',
  'category': 'test-category',
  'thumbnail': 'https://example.com/product.jpg',
  'images': ['https://example.com/product.jpg'],
};

Product testProduct({int id = 1}) => Product.fromJson(productJson(id: id));

Map<String, dynamic> productsResponse({int id = 1}) => {
  'products': [productJson(id: id)],
  'total': 1,
  'skip': 0,
  'limit': 30,
};
