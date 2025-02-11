import 'package:get/get.dart';
import 'package:product_description/app/modules/product_details/bindings/product_binding.dart';
import 'package:product_description/app/modules/product_details/views/product_details_view.dart';

class AppPages {
  static const initial = Routes.productDetails;

  static final routes = [
    GetPage(
      name: Routes.productDetails,
      page: () => const ProductDetailsView(),
      binding: ProductBinding(),
    ),
  ];
}

abstract class Routes {
  static const productDetails = '/product-details';
}
