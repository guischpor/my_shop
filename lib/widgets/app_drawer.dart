import 'package:flutter/material.dart';
import 'package:my_shop/utils/app_routes.dart';

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
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.homePage,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.ordersPage,
              );
            },
          ),
        ],
      ),
    );
  }
}
