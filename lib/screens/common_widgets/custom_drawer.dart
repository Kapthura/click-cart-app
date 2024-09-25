import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() {
            final user = _authController.loggedUser.value;
            return UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? ""),
              accountEmail: Text(user?.email ?? ""),
              currentAccountPicture: FutureBuilder<Image>(
                future: _loadUserImage(user?.photoURL),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircleAvatar(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/default_avatar.png'),
                    );
                  } else {
                    return snapshot.data!;
                  }
                },
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            );
          }),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              await _authController.logout();
            },
          ),
        ],
      ),
    );
  }

  Future<Image> _loadUserImage(String? photoURL) async {
    if (photoURL == null || photoURL.isEmpty) {
      throw Exception('No photo URL');
    }
    final image = Image.network(photoURL);
    return image;
  }
}

