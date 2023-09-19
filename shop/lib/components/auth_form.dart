import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
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

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.Login;
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _passwordController = TextEditingController();

  final Map<String, String> _authData = {
    'email': '',
    'senha': '',
  };

  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _offsetAnimation;

  bool isSignUp() => _authMode == AuthMode.SignUp;
  bool isLogin() => _authMode == AuthMode.Login;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.linear,
    ));

    _offsetAnimation = Tween(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.linear,
    ));

    // _heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            )
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    Auth auth = Provider.of<Auth>(context, listen: false);

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    try {
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
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } on Error catch (error) {
      _showErrorDialog('Um erro inesperado ocorreu.');
    }

    setState(() => _isLoading = false);
  }

  void _switchMode() {
    setState(() {
      if (isLogin()) {
        _authMode = AuthMode.SignUp;
        _controller?.forward();
      } else {
        _authMode = AuthMode.Login;
        _controller?.reverse();
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuart,

          height: isLogin() ? 310 : 400,
          // height: _heightAnimation?.value.height ?? (isLogin() ? 310 : 400),
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
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: isLogin() ? 0 : 60,
                    maxHeight: isLogin() ? 0 : 120,
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                  child: FadeTransition(
                    opacity: _opacityAnimation!,
                    child: SlideTransition(
                      position: _offsetAnimation!,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Confirme a senha'),
                        ),
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
                    ),
                  ),
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
            ),
          ),
        ));
  }
}
