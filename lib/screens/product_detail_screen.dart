import 'package:cached_network_image/cached_network_image.dart';
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
      setState(() {});
    });
  }

  Future<List<String>> _fetchImages() async {
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
      appBar: AppBar(
        title: const Text('ClickCart'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  FutureBuilder<List<String>>(
                    future: _imageFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: 200, // Keep the height fixed
                          width: double.infinity,
                          color: Colors.grey[200], // Optional background color
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      final images = snapshot.data ?? [];

                      if (images.isEmpty) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Center(
                              child: Image.asset('assets/images/dummy.png')),
                        );
                      } else if (images.length == 1) {
                        // Show a single image
                        return
                        Center(
                          child: CachedNetworkImage(
                            imageUrl:  images[0],
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset('assets/images/dummy.png'),
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        );
                      } else {
                        return CarouselSlider.builder(
                          itemCount: images.length,
                          itemBuilder: (context, index, realIndex) {
                            final image = images[index];
                            return
                            CachedNetworkImage(
                              imageUrl:  image,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Image.asset('assets/images/dummy.png'),
                              height: 200,
                              fit: BoxFit.contain,
                            );
                          },
                          options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              setState(() {});
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Details Section
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.title}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${product.brand}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            '${((product.rating ?? 0) * 10).round() / 10.0}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(width: 6.0),
                          Row(
                            children: List.generate(5, (index) {
                              final roundedRating =
                                  ((product.rating ?? 0) * 10).round() / 10.0;

                              return Icon(
                                index <
                                        roundedRating
                                            .toInt() // Use the rounded rating for comparison
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              );
                            }),
                          ),
                        ],
                      ),

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
      ),
    );
  }
}
