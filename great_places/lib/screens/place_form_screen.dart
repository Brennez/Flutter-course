import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input_widget.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  TextEditingController _titleController = TextEditingController();
  File? _pickedImage;

  final _formKey = GlobalKey<FormState>();

  _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid || _pickedImage == null) return;

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
    );

    Navigator.pop(context);

    _formKey.currentState?.save();
  }

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo lugar'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          label: Text('Título'),
                        ),
                        validator: (_value) {
                          String value = _value ?? '';
                          if (value.isEmpty) {
                            return 'Campo não pode ser vazio!';
                          }

                          if (value.trim().length < 3) {
                            return 'Campo deve ter pelo menos 3 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ImageInputWidget(onSelectedImage: this._selectedImage),
                    ],
                  ),
                ),
              ),
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () => _submitForm(),
              icon: Icon(Icons.add),
              label: Text('Adicionar'),
            )
          ],
        ),
      ),
    );
  }
}
