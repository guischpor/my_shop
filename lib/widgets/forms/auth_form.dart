import 'package:flutter/material.dart';
import 'package:my_shop/core/exceptions/auth_exception.dart';
import 'package:my_shop/providers/auth_form_provider.dart';
import 'package:my_shop/providers/auth_provider.dart';
import 'package:my_shop/widgets/forms/text_form_component.dart';
import 'package:provider/provider.dart';

import '../show_dialog_message.dart';

enum AuthMode {
  signUp,
  login,
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.login;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  AnimationController? _animationController;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.linear,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _animationController?.dispose();
  }

  bool _isLogin() => _authMode == AuthMode.login;
  // bool _isSignUp() => _authMode == AuthMode.signUp;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signUp;
        _animationController?.forward();
      } else {
        _authMode = AuthMode.login;
        _animationController?.reverse();
      }
    });
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    AuthProvider auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        //Enviar Requisi????o de login
        await auth.signIn(_authData['email']!, _authData['password']!);
      } else {
        //Enviar Requisi????o de SignUp
        await auth.signup(_authData['email']!, _authData['password']!);
      }
    } on AuthException catch (error) {
      return showDialogMessage(
        context: context,
        message: error.toString(),
        textButton: 'OK',
        onTapButton: () {
          Navigator.of(context).pop();
          setState(() => _isLoading = false);
        },
      );
    } catch (error) {
      return showDialogMessage(
        context: context,
        message: 'Ocorreu um erro inesperado!',
        textButton: 'OK',
        onTapButton: () {
          Navigator.of(context).pop();
          setState(() => _isLoading = false);
        },
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final AuthFormProvider authFormProvider = Provider.of(context);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(16),
        // height: _heightAnimation?.value.height ?? (_isLogin() ? 310 : 400),
        height: _isLogin() ? 310 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormComponent(
                labelText: 'E-mail',
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  return authFormProvider.validateFormEmail(email);
                },
              ),
              TextFormComponent(
                labelText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: _passwordController,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (_password) {
                  final password = _password ?? '';
                  return authFormProvider.validateFormPassword(password);
                },
              ),
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isLogin() ? 0 : 60,
                  maxHeight: _isLogin() ? 0 : 120,
                ),
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormComponent(
                      labelText: 'Password Confirmation',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: _isLogin()
                          ? null
                          : (_password) {
                              final password = _password ?? '';
                              return authFormProvider
                                  .validateFormConfirmationPassword(
                                      password, _passwordController);
                            },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () => _submit(),
                  child: Text(
                    _authMode == AuthMode.login ? 'Login' : 'Create an account',
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                  ),
                ),
              const Spacer(),
              TextButton(
                onPressed: () => _switchAuthMode(),
                child: Text(
                  _isLogin()
                      ? 'Create a new account!'
                      : 'Already have an account?',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
