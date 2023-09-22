import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInputWidget extends StatefulWidget {
  final Function(File) onSelectedImage;

  const ImageInputWidget({super.key, required this.onSelectedImage});

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();

    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
    ) as XFile;

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');

    widget.onSelectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text(
                  'Nenhuma imagem selecionada',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera_alt_rounded),
            label: Text('Tirar foto'),
          ),
        )
      ],
    );
  }
}
