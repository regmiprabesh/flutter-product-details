import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_description/app/core/values/app_colors.dart';
import 'package:product_description/app/data/models/product_model.dart';
import 'package:product_description/app/modules/product_details/controllers/product_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:product_description/app/modules/product_details/views/components/contact_seller_dialog.dart';

class ProductInfo extends GetView<ProductController> {
  final Product product;

  ProductInfo({Key? key, required this.product}) : super(key: key) {
    if (product.colorVariants.isNotEmpty) {
      controller.selectedColorId.value = product.colorVariants.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.brand,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Text(
          product.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        _buildRatingSection(),
        SizedBox(height: 16),
        _buildProductCode(),
        SizedBox(height: 16),
        _buildPriceSection(),
        if (product.colorVariants.isNotEmpty) ...[
          SizedBox(height: 16),
          _buildColorVariants(),
        ],
        SizedBox(height: 16),
        _buildExpandableSections(),
      ],
    );
  }

  Widget _buildProductCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          final selectedVariant = controller.selectedColorVariant;
          if (selectedVariant != null) {
            return Text(
              'Code: ${selectedVariant.productCode}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        RatingBarIndicator(
          rating: product.ratings,
          itemBuilder: (context, _) =>
              const Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: 20.0,
          unratedColor: Colors.amber.withAlpha(50),
        ),
        const SizedBox(width: 8),
        Text(
          '(${product.totalRatings} ratings)',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Obx(() {
          final selectedVariant = controller.selectedColorVariant;
          if (selectedVariant != null) {
            return Text(
              '₹${selectedVariant.strikePrice}',
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
                fontSize: 16,
              ),
            );
          }
          return Text(
            '₹${product.strikePrice}',
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              fontSize: 16,
            ),
          );
        }),
        const SizedBox(width: 8),
        Obx(() {
          final selectedVariant = controller.selectedColorVariant;
          if (selectedVariant != null) {
            return Text(
              '₹${selectedVariant.price}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            );
          }
          return Text('₹${product.price}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ));
        }),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF6688BB),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Obx(() {
            final selectedVariant = controller.selectedColorVariant;
            if (selectedVariant != null) {
              return Text(
                '₹${selectedVariant.offPercent}% OFF',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
            return Text(
              '${product.offPercent}% OFF',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildColorVariants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Colors',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: product.colorVariants.map((variant) {
              return Obx(() => GestureDetector(
                    onTap: () => controller.setSelectedColor(variant.id),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: controller.selectedColorId.value == variant.id
                              ? Colors.black
                              : Colors.transparent,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(int.parse(
                              variant.colorValue.replaceAll('#', '0xFF'))),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ));
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final selectedVariant = controller.selectedColorVariant;
          if (selectedVariant != null) {
            return Row(
              children: [
                Text(
                  selectedVariant.name,
                  style: const TextStyle(
                    color: Color(0xFF6688BB),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(#In Stock: ${selectedVariant.maxOrder})',
                  style: const TextStyle(
                    color: Color(0xFF6688BB),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Contact',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            ElevatedButton(
              onPressed: () => Get.dialog(const ContactSellerDialog()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF4F4F4),
                minimumSize: const Size(140, 45),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mail_outline, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'Message Us',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandableSections() {
    return Column(
      children: [
        _buildExpandableSection('Description', product.description),
        _buildExpandableSection('Ingredients', product.ingredient),
        _buildExpandableSection('How to Use', product.howToUse),
      ],
    );
  }

  Widget _buildExpandableSection(String title, String content) {
    return ExpansionTile(
      initiallyExpanded: title == 'Description',
      tilePadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: HtmlWidget(content),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
