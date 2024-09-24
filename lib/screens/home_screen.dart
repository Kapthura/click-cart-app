import 'package:flutter/material.dart';
import 'package:glamour_grove_cosmetics_app/screens/common_widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glamour Grove'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
