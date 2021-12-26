import 'package:flutter/material.dart';
import 'package:my_shop/providers/order_list.dart';
import 'package:my_shop/widgets/drawer/app_drawer.dart';
import 'package:my_shop/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (context, index) => OrderWidget(
          order: orders.items[index],
        ),
      ),
    );
  }
}
