import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import '../models/product/product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  late Future<List<String>> _imageFuture;
  late Product product; // Declare product variable

  @override
  void initState() {
    super.initState();
    // Ensure that Get.arguments is not null
    product =
        Get.arguments as Product? ?? Product(); // Use default or handle null
    _imageFuture = _fetchImages();
    _pageController.addListener(() {
      setState(() {
      });
    });
  }

  Future<List<String>> _fetchImages() async {
    await Future.delayed(const Duration(seconds: 2));
    return product.images ?? [];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title ?? '')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel Section
            Stack(
              alignment: Alignment.center,
              children: [
                FutureBuilder<List<String>>(
                  future: _imageFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Return a fixed-height container while loading
                      return Container(
                        height: 200, // Keep the height fixed
                        width: double.infinity,
                        color: Colors.grey[200], // Optional background color
                        child: const Center(
                            child:
                                CircularProgressIndicator()), // Center loading indicator
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final images = snapshot.data ?? [];

                    return CarouselSlider.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index, realIndex) {
                        final image = images[index];
                        return Image.network(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/dummy.png');
                          },
                        );
                      },
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Details Section
            Card(
              color: Colors.white, // Light background for details
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12), // Rounded corners for details
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating and Price
                    Row(
                      children: [
                        Text(
                          'Rating: ${product.rating}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(width: 4.0),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < (product.rating ?? 0).toInt()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 20,
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: \$${product.price}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    // Justified Description
                    Text(
                      product.description ?? '',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue), // Border color
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_shopping_cart,
                            color: Colors.blue),
                        // Icon color matching the border
                        padding: const EdgeInsets.all(
                            12), // Adjust padding as needed
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
