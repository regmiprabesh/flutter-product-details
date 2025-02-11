import '../models/product_model.dart';
import '../providers/product_provider.dart';

class ProductRepository {
  final ProductProvider provider;

  ProductRepository({required this.provider});

  Future<Product> getProductDetails(String slug) {
    return provider.getProductDetails(slug);
  }
}
