import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:produtoapp/auth/authFirebase.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _controllerName.text = _user!.displayName ?? '';
      _controllerEmail.text = _user!.email ?? '';
    }
  }

  Future<void> _updateProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(_controllerName.text);
        await user.updateEmail(_controllerEmail.text);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Informações atualizadas com sucesso!')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar as informações: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(_user?.photoURL ?? ''),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _controllerName,
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: TextStyle(color: Colors.blue[900]),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _controllerEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.blue[900]),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[900],
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text("Salvar Alterações", style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, '/listagem');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text("Sair", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
