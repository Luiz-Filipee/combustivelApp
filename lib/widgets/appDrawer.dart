import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  final VoidCallback onLogout;

  const AppDrawer({Key? key, required this.onLogout}) : super(key: key);

  @override
  State<AppDrawer> createState() {
    return AppDrawerState();
  }
}

class AppDrawerState extends State<AppDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_user?.displayName ?? "Usuário Nome"),
            accountEmail: Text(_user?.email ?? "usuario@email.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  _user?.photoURL ?? 'https://example.com/default-avatar.png'),
              child:
                  _user?.photoURL == null ? Icon(Icons.person, size: 40) : null,
            ),
            decoration: BoxDecoration(color: Colors.blue[900]),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () async {
              Navigator.pop(context); // Fecha o Drawer
              await Navigator.pushReplacementNamed(context, '/listagem');
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text("Meus Veículos"),
            onTap: () async {
              Navigator.pop(context); // Fecha o Drawer
              await Navigator.pushReplacementNamed(context, '/meus-veiculos');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Adicionar Veículo"),
            onTap: () async {
              Navigator.pop(context); // Fecha o Drawer
              await Navigator.pushReplacementNamed(
                  context, '/adicionar-veiculo');
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text("Histórico de Abastecimentos"),
            onTap: () async {
              Navigator.pop(context); // Fecha o Drawer
              await Navigator.pushReplacementNamed(
                  context, '/historico-abastecimentos');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Perfil"),
            onTap: () async {
              Navigator.pop(context); // Fecha o Drawer
              await Navigator.pushReplacementNamed(context, '/perfil');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async {
              await _auth.signOut();
              widget.onLogout();
            },
          ),
        ],
      ),
    );
  }
}
