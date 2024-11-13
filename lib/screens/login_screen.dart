
import 'package:flutter/material.dart';
import '../services/firebase_auth_service.dart';
import '../widgets/loading_indicator.dart';
import '../utils/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    String result = await FirebaseAuthService.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (result == 'success') {
      CustomSnackbar.show(context, 'Inicio de sesión exitoso');
    } else {
      CustomSnackbar.show(context, result);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            _isLoading
                ? LoadingIndicator()
                : ElevatedButton(
                    onPressed: _signIn,
                    child: Text('Iniciar sesión'),
                  ),
          ],
        ),
      ),
    );
  }
}
    