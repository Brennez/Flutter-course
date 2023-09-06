import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';

import '../models/products_list.dart';

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

  bool _isLoading = false;

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

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValidUrl && endsWithFile;
  }

  Future<void> submitForm() async {
    final provider = Provider.of<ProductList>(context, listen: false);

    final _isValid = _formKey.currentState?.validate() ?? false;

    if (!_isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await provider.saveProduct(_formData);
      Navigator.of(context).pop();
    } catch (error) {
      return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erro!'),
            content: Text('Ocorreu um erro ao adicionar o produto'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          );
        },
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null) {
      final product = args as Product;

      _formData['id'] = product.id;
      _formData['name'] = product.name;
      _formData['price'] = product.price;
      _formData['description'] = product.description;
      _formData['urlImage'] = product.imageUrl;

      _imageController.text = product.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de produto'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: submitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Form(
          key: _formKey,
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_priceFocus);
                        },
                        onSaved: (nameValue) =>
                            _formData['name'] = nameValue ?? '',
                        validator: (_name) {
                          String name = _name ?? '';

                          if (name.trim().isEmpty) {
                            return 'O nome é obrigatório!';
                          }

                          if (name.trim().length < 3) {
                            return 'O nome deve ter no mínimo 3 letras!';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['price']?.toString(),
                        decoration: const InputDecoration(
                          label: Text('Preço'),
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocus,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocus);
                        },
                        onSaved: (priceValue) => _formData['price'] =
                            double.parse(priceValue ?? '0.0'),
                        validator: (_price) {
                          final priceString = _price ?? '';

                          final price = double.tryParse(priceString) ?? -1;

                          if (price <= 0) {
                            return 'Informe um preço válido!';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['description']?.toString(),
                        decoration: const InputDecoration(
                          label: Text('Descrição'),
                        ),
                        focusNode: _descriptionFocus,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        onSaved: (descriptionValue) =>
                            _formData['description'] = descriptionValue ?? '',
                        validator: (_description) {
                          String description = _description ?? '';

                          if (description.trim().isEmpty) {
                            return 'A descrição é obrigatória!';
                          }

                          if (description.trim().length < 10) {
                            return 'A descrição deve ter no mínimo 10 letras!';
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _imageController,
                              decoration: const InputDecoration(
                                label: Text('URL da imagem'),
                              ),
                              focusNode: _imageUrlFocus,
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (value) => submitForm,
                              onSaved: (urlImageValue) =>
                                  _formData['urlImage'] = urlImageValue ?? '',
                              validator: (_url) {
                                String url = _url ?? '';

                                if (!isValidImageUrl(url)) {
                                  return 'Informe uma URL válida!';
                                }

                                return null;
                              },
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
                                ? const Text(
                                    'Informe a url',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  )
                                : Container(
                                    width: 80,
                                    height: 80,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child:
                                          Image.network(_imageController.text),
                                    ),
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
