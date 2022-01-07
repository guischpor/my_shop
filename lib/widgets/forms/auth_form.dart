import 'package:flutter/material.dart';
import 'package:my_shop/providers/auth_form_provider.dart';
import 'package:my_shop/widgets/forms/text_form_component.dart';
import 'package:provider/provider.dart';

enum AuthMode {
  signUp,
  login,
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.login;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignUp() => _authMode == AuthMode.signUp;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signUp;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    if(_isLogin()) {
      //Enviar Requisição de login
    } else {
      //Enviar Requisição de SignUp
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final AuthFormProvider authFormProvider = Provider.of(context);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
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
                if (_isSignUp())
                  TextFormComponent(
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
                const SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () => _submit(),
                    child: Text(
                      _authMode == AuthMode.login
                          ? 'Login'
                          : 'Create an account',
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8)),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: () => _switchAuthMode(),
                  child: Text(_isLogin()
                      ? 'Create a new account!'
                      : 'Already have an account?'),
                )
              ],
            )),
      ),
    );
  }
}
