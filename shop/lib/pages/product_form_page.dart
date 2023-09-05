import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final Map<String, Object> _formData = {};

  @override
  void initState() {
    _imageUrlFocus.addListener(updateImage);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  void submitForm() {
    _formKey.currentState?.save();

    var newProduct = Product(
      id: Random().nextDouble().toString(),
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['urlImage'] as String,
    );

    print(newProduct.id);
    print(newProduct.name);
    print(newProduct.description);
    print(newProduct.price);
    print(newProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de produto'),
        centerTitle: true,
        actions: [IconButton(onPressed: submitForm, icon: Icon(Icons.save))],
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Nome'),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (nameValue) => _formData['name'] = nameValue ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Preço'),
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocus,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  onSaved: (priceValue) =>
                      _formData['price'] = double.parse(priceValue ?? '0.0'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Descrição'),
                  ),
                  focusNode: _descriptionFocus,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (descriptionValue) =>
                      _formData['description'] = descriptionValue ?? '',
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _imageController,
                        decoration: InputDecoration(
                          label: Text('URL da imagem'),
                        ),
                        focusNode: _imageUrlFocus,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) => submitForm,
                        onSaved: (urlImageValue) =>
                            _formData['urlImage'] = urlImageValue ?? '',
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      margin: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _imageController.text.isEmpty
                          ? Text(
                              'Informe a url',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            )
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(_imageController.text),
                            ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
