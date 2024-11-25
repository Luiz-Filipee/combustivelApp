import 'package:flutter/material.dart';
import 'package:produtoapp/model/abastecimento.dart';
import 'package:produtoapp/repository/historicoAbastecimentoRepository.dart';

class RegistroAbastecimento extends StatefulWidget {
  @override
  _RegistroAbastecimentoState createState() => _RegistroAbastecimentoState();
}

class _RegistroAbastecimentoState extends State<RegistroAbastecimento> {
  final _formKey = GlobalKey<FormState>();
  final HistoricoAbastecimentoRepository _repository =
      HistoricoAbastecimentoRepository();
  final TextEditingController _litrosController = TextEditingController();
  final TextEditingController _quilometragemController =
      TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  void _registrarAbastecimento() async {
    if (_formKey.currentState!.validate()) {
      try {
        double litros = double.parse(_litrosController.text);
        int quilometragem = int.parse(_quilometragemController.text);
        DateTime data = DateTime.parse(_dataController.text);

        Abastecimento abastecimento = Abastecimento(
          veiculoId: null,
          quantidadeLitros: litros,
          quilometragem: quilometragem,
          data: data,
        );

        await _repository.adicionar(abastecimento);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Abastecimento registrado com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao registrar abastecimento: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrar Abastecimento',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _litrosController,
                decoration: InputDecoration(labelText: 'Quantidade de Litros'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade de litros';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _quilometragemController,
                decoration: InputDecoration(labelText: 'Quilometragem'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quilometragem';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dataController,
                decoration: InputDecoration(labelText: 'Data (AAAA-MM-DD)'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data do abastecimento';
                  }
                  try {
                    DateTime.parse(value);
                  } catch (_) {
                    return 'Data inválida! Use o formato AAAA-MM-DD.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrarAbastecimento,
                child: Text('Registrar Abastecimento'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  onPrimary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
