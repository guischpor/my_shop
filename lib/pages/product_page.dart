import 'package:flutter/material.dart';
import 'package:my_shop/widgets/drawer/app_drawer.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [],
      ),
    );
  }
}
