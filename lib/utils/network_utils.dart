import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class NetworkUtils {
  final AuthController _authController = Get.find<AuthController>();

  static Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      return false;
    }else{
      return true;
    }
  }

  // Method to check internet connection and handle navigation
  Future<void> checkConnectionAndProceed() async {
    // Check if the internet is available
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      showMessage();
      await _authController.logout();
    } else {
      //HTTP request to check the actual connection
      bool internetWorking = await testInternetConnection();
      if (!internetWorking) {
        showMessage();
        await _authController.logout();
      }
    }
  }

  void showMessage() {
    Get.snackbar(
      'No Internet', // Title
      'Internet connection is unavailable.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 10),
      backgroundColor: Colors.redAccent,
      colorText: Colors.white, // Text color
      margin: const EdgeInsets.all(10),
      borderRadius: 10, // Rounded corners
      icon: const Icon(Icons.wifi_off, color: Colors.white), // Add an icon
    );
  }

  // Method to test an HTTP connection to verify internet connectivity
  Future<bool> testInternetConnection() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      // Handle exception (e.g., no internet)
      return false;
    }
    return false;
  }
}
