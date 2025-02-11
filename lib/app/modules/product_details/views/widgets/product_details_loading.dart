import 'package:flutter/material.dart';
import 'package:product_description/app/core/widgets/shimmer_loading.dart';

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image gallery shimmer
          ShimmerLoading(
            child: Container(
              height: 340,
              color: Colors.white,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand name shimmer
                ShimmerLoading(
                  child: Container(
                    width: 100,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // Title shimmer
                ShimmerLoading(
                  child: Container(
                    width: double.infinity,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Rating shimmer
                Row(
                  children: [
                    ShimmerLoading(
                      child: Container(
                        width: 120,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ShimmerLoading(
                      child: Container(
                        width: 80,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Price shimmer
                Row(
                  children: [
                    ShimmerLoading(
                      child: Container(
                        width: 80,
                        height: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ShimmerLoading(
                      child: Container(
                        width: 100,
                        height: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Color variants shimmer
                ShimmerLoading(
                  child: Container(
                    width: 120,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ShimmerLoading(
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Description shimmer
                ...List.generate(
                  3,
                  (index) => Column(
                    children: [
                      ShimmerLoading(
                        child: Container(
                          width: double.infinity,
                          height: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),

                // Reviews shimmer
                const SizedBox(height: 24),
                ShimmerLoading(
                  child: Container(
                    width: 150,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(
                  2,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ShimmerLoading(
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
