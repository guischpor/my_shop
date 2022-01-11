import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/form_product_provider.dart';
import 'package:my_shop/providers/product_list_provider.dart';
import 'package:my_shop/core/utils/formatters/real_money_formatter.dart';
import 'package:my_shop/widgets/forms/text_form_component.dart';
import 'package:my_shop/widgets/show_dialog_message.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;

        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
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

  //funcao que salva os dados em uma lista!
  Future<void> submitForm({
    required GlobalKey<FormState> formKey,
    required Map<String, Object> formData,
  }) async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProductListProvider>(
        context,
        listen: false,
      ).saveProduct(formData, context);

      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      await showDialogMessage(
        context: context,
        message:
            'There was an error saving the product! Contact system support!',
        textButton: 'OK',
        onTapButton: () {
          Navigator.of(context).pop();
        },
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Product Form'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.save),
        onPressed: () => submitForm(
          formKey: _formKey,
          formData: _formData,
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
              initialValue: _formData['name']?.toString(),
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
              initialValue: _formData['price']?.toString(),
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
              initialValue: _formData['description']?.toString(),
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
                    onFieldSubmitted: (_) => submitForm(
                      formKey: _formKey,
                      formData: _formData,
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
                          height: 100,
                          width: 100,
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
