import 'package:my_shop/models/cart_item.dart';

class OrderModel {
  final String id;
  final double total;
  final List<CartItemModel> products;
  final DateTime date;

  OrderModel({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}
