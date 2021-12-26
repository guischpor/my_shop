import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  //estrutura do componente
  Widget _body() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: _panelButtons(),
    );
  }

  //estrutura do painel
  Widget _panelButtons() {
    return Container(
      width: 100,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.purple,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red[700],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
