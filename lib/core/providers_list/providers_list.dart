import 'package:my_shop/core/services/client_http.dart';
import 'package:my_shop/providers/auth_form_provider.dart';
import 'package:my_shop/providers/auth_provider.dart';
import 'package:my_shop/providers/cart_provider.dart';
import 'package:my_shop/providers/categories_form_provider.dart';
import 'package:my_shop/providers/categories_provider.dart';
import 'package:my_shop/providers/form_product_provider.dart';
import 'package:my_shop/providers/order_list_provider.dart';
import 'package:my_shop/providers/product_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProvidersList {
  final List<SingleChildWidget> providers = [
    Provider(
      create: (_) => ClientHttp(),
    ),
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
    ),
    ChangeNotifierProxyProvider<AuthProvider, ProductListProvider>(
      create: (context) => ProductListProvider(context.read()),
      update: (context, auth, previous) {
        return ProductListProvider(
          ClientHttp(),
          auth.token ?? '',
          auth.userId ?? '',
          previous?.items ?? [],
        );
      },
    ),
    ChangeNotifierProxyProvider<AuthProvider, OrderListProvider>(
      create: (_) => OrderListProvider(),
      update: (context, auth, previous) {
        return OrderListProvider(
          auth.token ?? '',
          auth.userId ?? '',
          previous?.items ?? [],
        );
      },
    ),
    ChangeNotifierProxyProvider<AuthProvider, CategoriesProvider>(
      create: (_) => CategoriesProvider(),
      update: (context, auth, previous) {
        return CategoriesProvider(
          auth.token ?? '',
          previous?.items ?? [],
        );
      },
    ),
    ChangeNotifierProvider(
      create: (_) => CategoriesFormProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => FormProductProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => AuthFormProvider(),
    ),
  ];
}
