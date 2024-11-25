import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:produtoapp/auth/authFirebase.dart';
import 'package:produtoapp/controller/loginController.dart';
import 'package:produtoapp/model/veiculo.dart';
import 'package:produtoapp/repository/veiculoRepository.dart';
import 'package:produtoapp/widgets/appDrawer.dart';
import 'package:produtoapp/widgets/cadastroVeiculo.dart';

class ListagemVeiculos extends StatefulWidget {
  @override
  State<ListagemVeiculos> createState() {
    return ListagemVeiculosEstado();
  }
}

class ListagemVeiculosEstado extends State<ListagemVeiculos> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final VeiculoRepository _repository = VeiculoRepository();
  final LoginController _controller = LoginController(AutenticacaoFirebase());
  List<Veiculo> _veiculos = [];
  Map<String?, double> _mediaConsumo = {};

  @override
  void initState() {
    super.initState();
    atualizarLista();
  }

  void atualizarLista() async {
    try {
      List<Veiculo> veiculos = await _repository.obterTodos();
      setState(() {
        _veiculos = veiculos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar veículos: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Lista de Veículos',
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.blue[900],
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu),
          color: Colors.white,
        ),
      ),
      drawer: AppDrawer(
        onLogout: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
      body: _veiculos.isEmpty
          ? Center(
              child: const Text('Nenhum veículo cadastrado!',
                  style: TextStyle(fontSize: 20)))
          : ListView.builder(
              itemCount: _veiculos.length,
              itemBuilder: (context, index) {
                Veiculo veiculo = _veiculos[index];
                // Card que representa cada veículo cadastrado
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    title: Text(veiculo.nome!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Modelo: ${veiculo.modelo}\nAno: ${veiculo.ano}\nPlaca: ${veiculo.placa}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 15),
                    ),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastroVeiculo(
                            repository: _repository,
                            veiculo: veiculo,
                          ),
                        ),
                      ).then((_) {
                        atualizarLista();
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroVeiculo(repository: _repository),
            ),
          ).then((_) {
            atualizarLista();
          });
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
