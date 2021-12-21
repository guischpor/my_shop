import 'package:flutter/material.dart';
import 'package:my_shop/models/cart.dart';
import 'package:my_shop/providers/order_list.dart';
import 'package:my_shop/widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    backgroundColor: Colors.purple,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    child: const Text('PAY'),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        color: Colors.purple,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<OrderList>(
                        context,
                        listen: false,
                      ).addOrder(cart);

                      cart.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => CartItemWidget(
                items[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
