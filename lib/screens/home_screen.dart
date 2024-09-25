import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamour_grove_cosmetics_app/screens/common_widgets/custom_drawer.dart';

import '../controllers/product_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickCart'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: GridView.builder(
            itemCount: productController.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.64,
            ),
            itemBuilder: (context, index) {
              var product = productController.productList[index];
              return GestureDetector(
                  onTap: () {
                    Get.toNamed('/productDetail', arguments: product);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // Rounded corners
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  // Product image
                                  Image.network(
                                    product.thumbnail ?? '',
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/dummy.png',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Product title
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.title ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              maxLines: 2, // Limit title to one line
                              overflow: TextOverflow.ellipsis, // Add ellipsis if title is too long
                            ),
                          ),

                          // Product brand and verified icon
                          if (product.brand != null && product.brand!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    // Make the row flexible
                                    child: Text(
                                      product.brand ?? '',
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(Icons.verified, color: Colors.blue, size: 16),
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              children: [
                                Flexible( // Use Flexible to ensure text stays within bounds
                                  child: Text(
                                    '\$${product.price}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis, // Add ellipsis if text is too long
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ));
            },
          ),
        );
      }),
    );
  }
}
