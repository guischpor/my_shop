import 'package:flutter/material.dart';
import 'package:my_shop/providers/order_list_provider.dart';
import 'package:my_shop/widgets/drawer/app_drawer.dart';
import 'package:my_shop/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderListProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => orders.refreshOrders(context),
        child: FutureBuilder(
          future: orders.loadingOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return const Center(child: Text('Error loading my orders!'));
            } else {
              return Consumer<OrderListProvider>(
                builder: (context, orders, child) => orders.items.isEmpty
                    ? const Center(
                        child: Text('There is no order in your list!'),
                      )
                    : ListView.builder(
                        itemCount: orders.itemsCount,
                        itemBuilder: (context, index) => OrderWidget(
                          order: orders.items[index],
                        ),
                      ),
              );
            }
          },
        ),
      ),
    );
  }
}
