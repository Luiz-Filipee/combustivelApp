import 'package:flutter/material.dart';
import 'package:produtoapp/model/veiculo.dart';
import 'package:produtoapp/repository/veiculoRepository.dart';

class CadastroVeiculo extends StatefulWidget {
  final VeiculoRepository repository;
  final Veiculo? veiculo;

  CadastroVeiculo({required this.repository, this.veiculo});

  @override
  State<CadastroVeiculo> createState() => CadastroVeiculoEstado();
}

class CadastroVeiculoEstado extends State<CadastroVeiculo> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllernModelo = TextEditingController();
  TextEditingController _controllerAno = TextEditingController();
  TextEditingController _controllerMediaConsumo = TextEditingController();
  TextEditingController _controllerPlaca = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double? _mediaConsumo;

  @override
  void initState() {
    super.initState();
    if (widget.veiculo != null) {
      _controllerNome.text = widget.veiculo!.nome!;
      _controllernModelo.text = widget.veiculo!.modelo!;
      _controllerAno.text = widget.veiculo!.ano!;
      _controllerPlaca.text = widget.veiculo!.placa!;
      _calcularMediaConsumo();
    }
  }

  void _calcularMediaConsumo() async {
    if (widget.veiculo != null) {
      double media =
          await widget.repository.calcularMediaConsumo(widget.veiculo!.id!);
      setState(() {
        _controllerMediaConsumo.text = media.toStringAsFixed(2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.veiculo == null ? "Cadastro Veiculo" : "Editar Veiculo",
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _controllerNome,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome do veiculo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controllernModelo,
                decoration: InputDecoration(
                  labelText: 'modelo',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controllerAno,
                decoration: InputDecoration(
                  labelText: '2021',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controllerPlaca,
                decoration: InputDecoration(
                  labelText: 'A23DFRA',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _controllerMediaConsumo,
                decoration: InputDecoration(
                  labelText: 'Média de Consumo (km/l)',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                enabled: false,
                readOnly: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String nomeInformado = _controllerNome.text;
                    String modeloformado = _controllernModelo.text;
                    String anoInformado = _controllerAno.text;
                    String placaInformada = _controllerPlaca.text;

                    Veiculo veiculo = Veiculo(
                        id: widget.veiculo?.id,
                        nome: nomeInformado,
                        modelo: modeloformado,
                        ano: anoInformado,
                        placa: placaInformada);

                    try {
                      if (widget.veiculo == null) {
                        await widget.repository.adicionar(veiculo);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Veículo cadastrado com sucesso!')),
                        );
                        Navigator.pushReplacementNamed(context, '/listagem');
                      } else {
                        await widget.repository.atualizar(veiculo);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Veículo atualizado com sucesso!')),
                        );
                      }
                      Navigator.pushReplacementNamed(context, '/listagem');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao salvar veículo: $e')),
                      );
                    }
                  }
                },
                child: Text(
                    widget.veiculo == null
                        ? "Cadastrar Veiculo"
                        : "Salvar Alterações",
                    style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 16),
              if (widget.veiculo != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    widget.repository.deletar(widget.veiculo!);
                    print('Veiculo deletado com sucesso!');
                    Navigator.pop(context);
                  },
                  child:
                      Text("Deletar Veiculo", style: TextStyle(fontSize: 18)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
