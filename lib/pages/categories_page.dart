import 'package:flutter/material.dart';
import 'package:my_shop/core/utils/app_routes.dart';
import 'package:my_shop/widgets/drawer/app_drawer.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories Page'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Categories Page'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.categoriesFormPage,
          );
        },
      ),
    );
  }
}
