import 'package:get/get.dart';
import 'package:product_description/app/data/providers/product_provider.dart';
import 'package:product_description/app/data/repositories/product_repository.dart';
import 'package:product_description/app/modules/product_details/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductProvider());
    Get.lazyPut(() => ProductRepository(provider: Get.find<ProductProvider>()));
    Get.lazyPut(
        () => ProductController(repository: Get.find<ProductRepository>()));
  }
}
