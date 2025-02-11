import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_description/app/data/models/product_model.dart';
import 'package:product_description/app/data/models/review_model.dart';
import 'package:product_description/app/modules/product_details/views/components/add_review_dialog.dart';

class ReviewSection extends StatelessWidget {
  final Product product;

  const ReviewSection({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews & Ratings',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        _buildOverallRating(),
        const SizedBox(height: 16),
        _buildAddReviewButton(),
        const SizedBox(height: 16),
        _buildReviewsList(),
      ],
    );
  }

  Widget _buildOverallRating() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                product.ratings.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RatingBarIndicator(
                rating: product.ratings,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                unratedColor: Colors.amber.withAlpha(50),
              ),
              Text(
                'Based on ${product.totalRatings} reviews',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              children: [
                _buildRatingBar(5, 0.7),
                _buildRatingBar(4, 0.2),
                _buildRatingBar(3, 0.05),
                _buildRatingBar(2, 0.03),
                _buildRatingBar(1, 0.02),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int rating, double percentage) {
    return Row(
      children: [
        Text(
          '$rating',
          style: const TextStyle(fontSize: 14),
        ),
        const Icon(Icons.star, size: 15, color: Colors.amber),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6688BB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${(percentage * 100).toInt()}%',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAddReviewButton() {
    return ElevatedButton(
      onPressed: () => Get.dialog(const AddReviewDialog()),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Write a Review',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildReviewsList() {
    // Sample reviews - in real app, this would come from API
    final reviews = [
      Review(
        userName: "John Doe",
        rating: 4.5,
        comment:
            "Great product! The color is exactly as shown in the pictures.",
        date: "2024-02-01",
      ),
      Review(
        userName: "Jane Smith",
        rating: 5.0,
        comment: "Amazing quality and fast delivery. Highly recommended!",
        date: "2024-01-28",
      ),
    ];

    return Column(
      children: reviews.map((review) => _buildReviewCard(review)).toList(),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                review.date,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RatingBarIndicator(
            rating: review.rating,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 16,
            unratedColor: Colors.amber.withAlpha(50),
          ),
          const SizedBox(height: 8),
          Text(review.comment),
        ],
      ),
    );
  }
}
