import 'package:flutter/material.dart';
import 'package:my_shop/models/categories_model.dart';
import 'package:my_shop/providers/categories_form_provider.dart';
import 'package:my_shop/providers/categories_provider.dart';
import 'package:my_shop/widgets/forms/text_form_component.dart';
import 'package:my_shop/widgets/show_dialog_message.dart';
import 'package:provider/provider.dart';

class CategoriesFormPage extends StatefulWidget {
  const CategoriesFormPage({Key? key}) : super(key: key);

  @override
  _CategoriesFormPageState createState() => _CategoriesFormPageState();
}

class _CategoriesFormPageState extends State<CategoriesFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final categorie = arg as CategoriesModel;
        _formData['id'] = categorie.id;
        _formData['name'] = categorie.name;
      }
    }
  }

  Future<void> submitForm({
    required GlobalKey<FormState> formKey,
    required Map<String, Object> formData,
  }) async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<CategoriesProvider>(
        context,
        listen: false,
      ).saveCategorie(
        formData,
        context,
      );

      Navigator.of(context).pop();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      await showDialogMessage(
        context: context,
        message:
            'There was an error saving the categories! Contact system support!',
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
      appBar: AppBar(
        title: const Text('Categories Form Page'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _body(context),
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

  Widget _body(BuildContext context) {
    final categoriesForm = Provider.of<CategoriesFormProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormComponent(
              labelText: 'Categorie Name',
              initialValue: _formData['name']?.toString(),
              keyboardType: TextInputType.name,
              onSaved: (name) => _formData['name'] = name ?? '',
              validator: (_name) {
                final name = _name ?? '';
                return categoriesForm.validateFormName(name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
