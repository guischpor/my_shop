import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_shop/utils/formatters/real_money_formatter.dart';
import 'package:my_shop/widgets/forms/text_form_component.dart';
import 'dart:io';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceController = TextEditingController();

  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _priceController.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
  }

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
          children: [
            TextFormComponent(
              labelText: 'Nome',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocus);
              },
            ),
            const SizedBox(height: 10),
            TextFormComponent(
              labelText: 'Preço',
              textInputAction: TextInputAction.next,
              keyboardType: Platform.isIOS
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.number,
              controller: _priceController,
              focusNode: _priceFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocus);
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RealMoneyFormatter(),
              ],
            ),
            const SizedBox(height: 10),
            TextFormComponent(
              labelText: 'Descrição',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocus,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
