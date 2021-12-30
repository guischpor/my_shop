import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/form_product_provider.dart';
import 'package:my_shop/utils/formatters/real_money_formatter.dart';
import 'package:my_shop/widgets/forms/text_form_component.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  // final _nameController = TextEditingController();
  // final _priceController = TextEditingController();
  // final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final _formData = <String, Object>{};
  

  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    // _nameController.dispose();
    // _descriptionController.dispose();
    // _priceController.dispose();
    // _imageUrlController.dispose();
    _imageUrlController.removeListener(_updateImage);

    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
  }

  void _updateImage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final FormProductProvider formProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Form'),
        centerTitle: true,
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.save),
        onPressed: () => formProvider.submitForm(
          formKey: _formKey,
          formData: _formData,
          context: context,
        ),
      ),
    );
  }

  Widget _body() {
    final FormProductProvider formProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormComponent(
              labelText: 'Product Name',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              // controller: _nameController,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocus);
              },
              onSaved: (name) => _formData['name'] = name ?? '',
              validator: (_name) {
                final name = _name ?? '';
                return formProvider.validateFormName(name);
              },
            ),
            const SizedBox(height: 10),
            TextFormComponent(
              labelText: 'Price',
              textInputAction: TextInputAction.next,
              keyboardType: Platform.isIOS
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.number,
              // controller: _priceController,
              focusNode: _priceFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocus);
              },
              onSaved: (price) =>
                  _formData['price'] = double.parse(price ?? '0'),
              validator: (_price) {
                final priceString = _price ?? '-1';
                return formProvider.validateFormPrice(priceString);
              },
              // inputFormatters: [
              //   FilteringTextInputFormatter.digitsOnly,
              //   RealMoneyFormatter(),
              // ],
            ),
            const SizedBox(height: 10),
            TextFormComponent(
              labelText: 'Description',
              keyboardType: TextInputType.multiline,
              // controller: _descriptionController,
              focusNode: _descriptionFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_imageUrlFocus);
              },
              maxLines: 3,
              onSaved: (description) =>
                  _formData['description'] = description ?? '',
              validator: (_description) {
                final description = _description ?? '';
                return formProvider.validateFormDescription(description);
              },
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormComponent(
                    labelText: 'URL Image',
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    focusNode: _imageUrlFocus,
                    controller: _imageUrlController,
                    onFieldSubmitted: (_) => formProvider.submitForm(
                      formKey: _formKey,
                      formData: _formData,
                      context: context,
                    ),
                    onSaved: (imageUrl) =>
                        _formData['imageUrl'] = imageUrl ?? '',
                    validator: (_imageUrl) {
                      final imageUrl = _imageUrl ?? '';
                      return formProvider.isValidImageUrl(imageUrl);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: _imageUrlController.text.isEmpty
                      ? const Text('Inform the Url')
                      : Image.network(
                          _imageUrlController.text,
                          fit: BoxFit.cover,
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
