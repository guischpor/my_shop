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
      create: (_) => ProductListProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => OrderListProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => FormProductProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => AuthFormProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
    ),
  ];
}