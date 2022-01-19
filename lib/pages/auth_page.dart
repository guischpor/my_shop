import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_shop/widgets/forms/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _background(),
        _body(context),
      ],
    ));
  }

  Widget _body(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleApp(),
              const SizedBox(height: 20),
              const AuthForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _background() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(215, 117, 255, 0.5),
            Color.fromRGBO(255, 188, 117, 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _titleApp() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 50,
      ),
      transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepOrange.shade900,
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black26,
              offset: Offset(0, 2),
            )
          ]),
      child: const Text(
        'My Shop',
        style: TextStyle(
          fontSize: 45,
          fontFamily: 'Anton',
          color: Colors.white,
        ),
      ),
    );
  }
}
