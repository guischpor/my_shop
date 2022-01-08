import 'package:flutter/material.dart';
import 'package:my_shop/pages/auth_page.dart';
import 'package:my_shop/pages/products_overwiew_page.dart';
import 'package:my_shop/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of(context);

    return auth.isAuth ? const ProductsOverViewPage() : const AuthPage();
  }
}
