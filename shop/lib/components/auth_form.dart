import 'package:flutter/material.dart';

enum AuthMode {
  SignUp,
  Login,
}

class AuthForm extends StatefulWidget {
  AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final AuthMode _authMode = AuthMode.Login;
  TextEditingController _passwordController = TextEditingController();

  final Map<String, String> _authData = {
    'email': '',
    'senha': '',
  };

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 320,
        width: deviceSize.width * 0.80,
        padding: EdgeInsets.all(16),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text('E-mail')),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) => _authData['email'] = email ?? '',
              validator: (_email) {
                String email = _email ?? '';

                if (email.trim().isEmpty || email.trim().contains('@')) {
                  return 'Informe um e-mail válido!';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(label: Text('Senha')),
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              onSaved: (password) => _authData['password'] = password ?? '',
              validator: (_password) {
                String password = _password ?? '';

                if (password.trim().isEmpty || password.length < 6) {
                  return 'Informe uma senha válida!';
                } else {
                  return null;
                }
              },
            ),
            if (_authMode == AuthMode.SignUp)
              TextFormField(
                decoration:
                    const InputDecoration(label: Text('Confirme a senha')),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                validator: _authMode == AuthMode.Login
                    ? null
                    : (_password) {
                        String password = _password ?? '';

                        if (_passwordController.text != password) {
                          return 'As senhas são diferentes!';
                        } else {
                          return null;
                        }
                      },
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 30)),
              onPressed: _submit,
              child: Text(
                _authMode == AuthMode.Login ? 'LOGIN' : 'CADASTRAR',
              ),
            )
          ],
        )),
      ),
    );
  }
}
