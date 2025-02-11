import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ImageGallery extends StatelessWidget {
  final List<String> images;
  final RxInt selectedImageIndex = 0.obs;
  final PageController pageController = PageController();

  ImageGallery({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () => _showFullScreen(context),
              child: SizedBox(
                height: 340,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: images.length,
                  onPageChanged: (index) => selectedImageIndex.value = index,
                  itemBuilder: (context, index) {
                    return _buildImage(images[index]);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Obx(() => _buildPageIndicator()),
            ),
          ],
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Obx(() => _buildThumbnail(index));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerEffect({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildShimmerEffect(
          width: double.infinity,
          height: 340,
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        images.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                selectedImageIndex.value == index ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(int index) {
    return GestureDetector(
      onTap: () => pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      child: Container(
        width: 80,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedImageIndex.value == index
                ? Colors.black
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: images[index],
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildShimmerEffect(
              width: 80,
              height: 80,
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 24,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showFullScreen(BuildContext context) {
    Get.to(
      () => FullScreenGallery(
        images: images,
        initialIndex: selectedImageIndex.value,
      ),
    );
  }
}

class FullScreenGallery extends StatelessWidget {
  final List<String> images;
  final int initialIndex;
  final RxInt currentIndex;
  final PageController pageController;

  FullScreenGallery({
    super.key,
    required this.images,
    required this.initialIndex,
  })  : currentIndex = initialIndex.obs,
        pageController = PageController(initialPage: initialIndex);

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: images.length,
              onPageChanged: (index) => currentIndex.value = index,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => _buildShimmerEffect(),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[900],
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 16,
              right: 16,
              child: _buildCloseButton(),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: _buildThumbnailStrip(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Material(
      elevation: 4,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.white.withOpacity(0.9),
      child: InkWell(
        onTap: () => Get.back(),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: const Icon(Icons.close, color: Colors.black87, size: 24),
        ),
      ),
    );
  }

  Widget _buildThumbnailStrip() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Obx(() => _buildFullScreenThumbnail(index));
        },
      ),
    );
  }

  Widget _buildFullScreenThumbnail(int index) {
    return GestureDetector(
      onTap: () => pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      child: Container(
        width: 60,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: currentIndex.value == index
                ? const Color(0xFF6688BB)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: images[index],
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              color: Colors.black,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[900],
            child: const Center(
              child: Icon(
                Icons.image_not_supported,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
