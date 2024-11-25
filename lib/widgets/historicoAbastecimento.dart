import 'package:flutter/material.dart';
import 'package:produtoapp/model/abastecimento.dart';
import 'package:produtoapp/widgets/registroAbastecimento.dart';

import '../repository/historicoAbastecimentoRepository.dart';

class HistoricoAbastecimentoScreen extends StatefulWidget {
  @override
  _HistoricoAbastecimentoScreenState createState() =>
      _HistoricoAbastecimentoScreenState();
}

class _HistoricoAbastecimentoScreenState
    extends State<HistoricoAbastecimentoScreen> {
  final HistoricoAbastecimentoRepository _repository =
      HistoricoAbastecimentoRepository();
  late Future<List<Abastecimento>> _futureAbastecimentos;

  @override
  void initState() {
    super.initState();
    _futureAbastecimentos = _repository.obterHistoricoAbastecimentos();
  }

  void atualizarLista() {
    setState(() {
      _futureAbastecimentos = _repository.obterHistoricoAbastecimentos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Histórico de Abastecimentos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Abastecimento>>(
        future: _futureAbastecimentos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child:
                    Text('Erro ao carregar abastecimentos: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum abastecimento registrado.'));
          }

          var abastecimentos = snapshot.data!;

          return ListView.builder(
            itemCount: abastecimentos.length,
            itemBuilder: (context, index) {
              var abastecimento = abastecimentos[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading:
                      Icon(Icons.local_gas_station, color: Colors.blue[900]),
                  title: Text('Data: ${abastecimento.data.toLocal()}'),
                  subtitle: Text(
                    'Litros: ${abastecimento.quantidadeLitros}\nQuilometragem: ${abastecimento.quilometragem}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegistroAbastecimento(),
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
