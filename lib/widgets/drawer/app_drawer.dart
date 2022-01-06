import 'package:flutter/material.dart';
import 'package:my_shop/core/utils/app_routes.dart';
import 'package:my_shop/widgets/drawer/list_tile_drawer.dart';

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
                AppRoutes.homePage,
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
        ],
      ),
    );
  }
}
