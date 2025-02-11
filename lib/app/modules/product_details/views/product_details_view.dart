import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_description/app/modules/product_details/controllers/product_controller.dart';
import 'package:product_description/app/modules/product_details/views/widgets/image_gallery.dart';
import 'package:product_description/app/modules/product_details/views/widgets/product_actions.dart';
import 'package:product_description/app/modules/product_details/views/widgets/product_details_loading.dart';
import 'package:product_description/app/modules/product_details/views/widgets/product_info.dart';
import 'package:product_description/app/modules/product_details/views/widgets/review_section.dart';

class ProductDetailsView extends GetView<ProductController> {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const ProductDetailShimmer();
        }

        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        if (controller.product.value == null) {
          return const Center(child: Text('No product data available'));
        }

        return Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageGallery(images: controller.product.value!.images),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductInfo(product: controller.product.value!),
                        const SizedBox(height: 16),
                        ReviewSection(product: controller.product.value!),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ProductActions(),
            ),
          ],
        );
      }),
    );
  }
}
