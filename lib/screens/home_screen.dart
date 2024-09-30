import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamour_grove_cosmetics_app/screens/common_widgets/custom_drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              var product = productController.productList[index];
              return GestureDetector(
                  onTap: () {
                    Get.toNamed('/productDetail', arguments: product);
                  },
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
                          child: CachedNetworkImage(
                            imageUrl: product.thumbnail ?? '',
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset('assets/images/dummy.png'),
                            fit: BoxFit.contain,
                          ),
                        ),

                        // Product title
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    product.title ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                    maxLines: 2, // Limit title to one line
                                   // Add ellipsis if title is too long
                                  ),
                                ),
                              ],
                            ),
                        
                            // Product brand and verified icon
                            if (product.brand != null && product.brand!.isNotEmpty)
                              Row(
                                children: [
                                  Text(
                                    product.brand ?? '',
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Icon(Icons.verified, color: Colors.blue, size: 16),
                                ],
                              ),
                            Row(
                              children: [
                                Text(
                                  '\$${product.price}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis, // Add ellipsis if text is too long
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      ],
                    ),
                  ));
            },
          ),
        );
      }),
    );
  }
}
