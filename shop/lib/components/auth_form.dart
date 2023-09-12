import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';

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
  AuthMode _authMode = AuthMode.Login;
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _passwordController = TextEditingController();

  final Map<String, String> _authData = {
    'email': '',
    'senha': '',
  };

  bool isSignUp() => _authMode == AuthMode.SignUp;
  bool isLogin() => _authMode == AuthMode.Login;

  Future<void> _submit() async {
    Auth auth = Provider.of<Auth>(context, listen: false);

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    if (isLogin()) {
      await auth.login(
        _authData['email']!,
        _authData['password']!,
      );
    } else {
      await auth.signUp(
        _authData['email']!,
        _authData['password']!,
      );
    }

    setState(() => _isLoading = false);
  }

  void _switchMode() {
    setState(() {
      if (isLogin()) {
        _authMode = AuthMode.SignUp;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: isLogin() ? 310 : 400,
        width: deviceSize.width * 0.80,
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_passwordFocus),
                  decoration: const InputDecoration(label: Text('E-mail')),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (_email) {
                    String email = _email ?? '';

                    if (email.trim().isEmpty || !email.trim().contains('@')) {
                      return 'Informe um e-mail válido!';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  focusNode: _passwordFocus,
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
                if (isSignUp())
                  TextFormField(
                    decoration:
                        const InputDecoration(label: Text('Confirme a senha')),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: isLogin()
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
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 30)),
                    onPressed: _submit,
                    child: Text(
                      isLogin() ? 'LOGIN' : 'CADASTRAR',
                    ),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: () => _switchMode(),
                  child: Text(
                    isLogin() ? 'CRIAR CONTA?' : 'JÁ POSSUI CONTA?',
                  ),
                )
              ],
            )),
      ),
    );
  }
}
