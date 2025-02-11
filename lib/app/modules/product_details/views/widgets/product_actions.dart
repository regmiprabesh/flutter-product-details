import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_description/app/modules/product_details/controllers/product_controller.dart';

class ProductActions extends GetView<ProductController> {
  const ProductActions({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        bottom: 35,
        top: 10,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Decrement Button
                  InkWell(
                    onTap: controller.decrementQuantity,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:
                          const Icon(Icons.remove, color: Colors.red, size: 24),
                    ),
                  ),
                  // Quantity Display
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(
                      () => Text(
                        '${controller.quantity.value}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  // Increment Button
                  InkWell(
                    onTap: controller.incrementQuantity,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.add,
                          color: Theme.of(context).primaryColor, size: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                controller.addToCart();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6688BB),
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Add To Bag',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
