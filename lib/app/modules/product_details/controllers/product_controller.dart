import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_description/app/data/models/product_model.dart';
import 'package:product_description/app/data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository repository;
  ProductController({required this.repository});

  final Rx<Product?> product = Rx<Product?>(null);
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;
  final RxString selectedColorId = ''.obs;
  final RxInt quantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductData();
  }

  Future<void> fetchProductData() async {
    try {
      isLoading.value = true;
      final productData =
          await repository.getProductDetails('smart-sync-lipstick-233');
      product.value = productData;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void setSelectedColor(String colorId) {
    selectedColorId.value = colorId;
    if (selectedColorVariant != null) {
      quantity.value = selectedColorVariant!.minOrder;
    }
  }

  ColorVariant? get selectedColorVariant {
    if (selectedColorId.isEmpty || product.value == null) return null;
    return product.value!.colorVariants.firstWhere(
      (variant) => variant.id == selectedColorId.value,
      orElse: () => product.value!.colorVariants.first,
    );
  }

  double get currentPrice =>
      selectedColorVariant?.price ?? product.value?.price ?? 0;
  double get currentStrikePrice =>
      selectedColorVariant?.strikePrice ?? product.value?.strikePrice ?? 0;
  int get currentOffPercent =>
      selectedColorVariant?.offPercent ?? product.value?.offPercent ?? 0;
  int get minOrder => selectedColorVariant?.minOrder ?? 1;
  int get maxOrder => selectedColorVariant?.maxOrder ?? 1;

  void incrementQuantity() {
    if (quantity.value < maxOrder) {
      quantity.value++;
    } else {
      Get.snackbar(
          'Maximum Limit', 'Cannot exceed maximum order quantity of $maxOrder',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: EdgeInsets.symmetric(
              vertical: GetPlatform.isAndroid ? 90.0 : 60.0, horizontal: 16),
          backgroundColor: Colors.red);
    }
  }

  void decrementQuantity() {
    if (quantity.value > minOrder) {
      quantity.value--;
    } else {
      Get.snackbar('Minimum Limit',
          'Cannot go below minimum order quantity of $minOrder',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: EdgeInsets.symmetric(
              vertical: GetPlatform.isAndroid ? 90.0 : 60.0, horizontal: 16),
          backgroundColor: Colors.red);
    }
  }

  void addToCart() {
    if (selectedColorVariant == null) {
      Get.snackbar('Color Required', 'Please select a color variant',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: EdgeInsets.symmetric(
              vertical: GetPlatform.isAndroid ? 90.0 : 60.0, horizontal: 16),
          backgroundColor: Colors.red);

      return;
    }

    debugPrint('''
    Adding to cart:
    Product ID: ${product.value?.id}
    Color Variant ID: ${selectedColorVariant?.id}
    Product Code: ${selectedColorVariant?.productCode}
    Quantity: ${quantity.value}
    Price: ${selectedColorVariant?.price}
    ''');

    Get.snackbar('Success', 'Product added to bag',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        margin: EdgeInsets.symmetric(
            vertical: GetPlatform.isAndroid ? 90.0 : 60.0, horizontal: 16),
        backgroundColor: Colors.green);
  }
}
