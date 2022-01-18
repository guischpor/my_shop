import 'package:flutter/material.dart';
import 'package:my_shop/core/utils/app_routes.dart';
import 'package:my_shop/providers/auth_provider.dart';
import 'package:my_shop/widgets/drawer/list_tile_drawer.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Welcome User!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTileDrawer(
            icon: Icons.shop,
            title: 'Shop',
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.authOrHomePage,
              );
            },
          ),
          const Divider(),
          ListTileDrawer(
            icon: Icons.payment,
            title: 'My Orders',
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.ordersPage,
              );
            },
          ),
          const Divider(),
          ListTileDrawer(
            icon: Icons.edit,
            title: 'Manage Products',
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.productsPage,
              );
            },
          ),
          const Divider(),
          ListTileDrawer(
            icon: Icons.category,
            title: 'Manage Categories',
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.categoriesPage,
              );
            },
          ),
          const Divider(),
          ListTileDrawer(
            icon: Icons.exit_to_app,
            title: 'Logout',
            onTap: () {
              Provider.of<AuthProvider>(
                context,
                listen: false,
              ).logout();

              Navigator.of(context).pushReplacementNamed(
                AppRoutes.authOrHomePage,
              );
            },
          ),
        ],
      ),
    );
  }
}
