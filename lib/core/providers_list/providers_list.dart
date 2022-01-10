import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/auth_form_provider.dart';
import 'package:my_shop/providers/auth_provider.dart';
import 'package:my_shop/providers/cart_provider.dart';
import 'package:my_shop/providers/form_product_provider.dart';
import 'package:my_shop/providers/order_list_provider.dart';
import 'package:my_shop/providers/product_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProvidersList {
  final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
    ),
    ChangeNotifierProxyProvider<AuthProvider, ProductListProvider>(
      create: (_) => ProductListProvider('', []),
      update: (context, auth, previous) {
        return ProductListProvider(
          auth.token ?? '',
          previous?.items ?? [],
        );
      },
    ),
    ChangeNotifierProxyProvider<AuthProvider, OrderListProvider>(
      create: (_) => OrderListProvider('', []),
      update: (context, auth, previous) {
        return OrderListProvider(
          auth.token ?? '',
          previous?.items ?? [],
        );
      },
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
