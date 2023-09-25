import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input_widget.dart';
import '../widgets/location_input_widget.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  final _formKey = GlobalKey<FormState>();

  bool isValidForm() {
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  _submitForm() {
    if (!isValidForm()) return;

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
    );

    Navigator.pop(context);

    // _formKey.currentState?.save();
  }

  void _selectedImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectedPosition(LatLng pickedPosition) {
    setState(() {
      _pickedPosition = pickedPosition;
    });
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
                        onChanged: (value) {
                          setState(() {});
                        },
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
                      const SizedBox(
                        height: 20,
                      ),
                      LocationInputWidget(
                        onSelectedPosition: this._selectedPosition,
                      ),
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
              onPressed: isValidForm() ? _submitForm : null,
              icon: Icon(Icons.add),
              label: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
