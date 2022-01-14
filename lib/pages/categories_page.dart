import 'package:flutter/material.dart';
import 'package:my_shop/core/utils/app_routes.dart';
import 'package:my_shop/providers/categories_provider.dart';
import 'package:my_shop/widgets/categorie_item.dart';
import 'package:my_shop/widgets/drawer/app_drawer.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoriesProvider categories = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories Page'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => categories.refreshCategories(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: categories.itemsCount,
            itemBuilder: (context, index) => Column(
              children: [
                CategorieItem(
                  categorie: categories.items[index],
                ),
                const Divider(color: Colors.grey),
              ],
            ),
          ),
        ),
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
