import 'package:flutter/material.dart';
import 'package:produtoapp/auth/authFirebase.dart';

class RecuperacaoSenha extends StatefulWidget {
  @override
  _RecuperacaoSenhaState createState() => _RecuperacaoSenhaState();
}

class _RecuperacaoSenhaState extends State<RecuperacaoSenha> {
  final TextEditingController _emailController = TextEditingController();
  final AutenticacaoFirebase _authService = AutenticacaoFirebase();

  Future<void> _recuperarSenha(BuildContext context) async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira um e-mail válido.')),
      );
      return;
    }

    String resultado = await _authService.sendPasswordResetEmail(email);

    if (resultado == "E-mail de redefinição enviado com sucesso") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado)),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recuperar Senha',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Digite seu e-mail para receber um link de redefinição de senha.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _recuperarSenha(context),
              child: Text('Enviar E-mail'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[900],
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
