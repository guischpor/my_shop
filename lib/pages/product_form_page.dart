import 'package:flutter/material.dart';
import 'package:my_shop/widgets/forms/text_form_componente.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Form'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        child: ListView(
          children: const [
            TextFormComponent(
              labelText: 'Nome',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
            ),
          ],
        ),
      ),
    );
  }
}
