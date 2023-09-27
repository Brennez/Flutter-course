import 'dart:io';

import 'package:flutter/material.dart';

import '../core/models/auth_form_data.dart';
import '../components/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Function(AuthFormData) onSubmit;

  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthFormData _authFormData = AuthFormData();

  void _submit() {
    bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_authFormData.image == null && _authFormData.isSignup) {
      return showError('Imagem Não selecionada!');
    }

    widget.onSubmit(_authFormData);
  }

  void handleImagePick(File image) {
    _authFormData.image = image;
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(msg,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(20),
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_authFormData.isSignup)
                  UserImagePicker(onImagePick: handleImagePick),
                if (_authFormData.isSignup)
                  TextFormField(
                    key: const ValueKey('name'),
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                    initialValue: _authFormData.name,
                    onChanged: (name) {
                      _authFormData.name = name;
                    },
                    validator: (_email) {
                      final name = _email ?? '';

                      if (name.trim().length < 5) {
                        return 'Nome deve ter no mínimo 5 caracteres.';
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  key: ValueKey('email'),
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  initialValue: _authFormData.email,
                  onChanged: (email) {
                    _authFormData.email = email;
                  },
                  validator: (_email) {
                    final email = _email ?? '';

                    if (!email.contains('@')) {
                      return 'Informe um e-mail válido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  key: ValueKey('password'),
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.remove_red_eye),
                      onTap: () {},
                    ),
                    labelText: 'Senha',
                  ),
                  initialValue: _authFormData.password,
                  onChanged: (password) {
                    _authFormData.password = password;
                  },
                  validator: (_password) {
                    final password = _password ?? '';

                    if (password.trim().length < 6) {
                      return 'Senha deve ter no mínimo 6 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: _submit,
                  child: Text(
                    _authFormData.isLogin ? "Entrar" : "Cadastrar",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _authFormData.toggleAuthMode();
                    });
                  },
                  child: Text(
                    _authFormData.isLogin ? 'Criar conta?' : 'Já possui conta?',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
