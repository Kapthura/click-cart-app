import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

import '../models/product/product.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  final _logger = Logger();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse("https://dummyjson.com/products"));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var products = (jsonData['products'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
        productList.value = products;
      }
      _logger.i(productList);
    } finally {
      isLoading(false);
    }
  }
}
