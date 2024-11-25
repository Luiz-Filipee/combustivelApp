import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:produtoapp/repository/veiculoRepository.dart';
import 'package:produtoapp/widgets/autenticacaoUser.dart';
import 'package:produtoapp/widgets/cadastroVeiculo.dart';
import 'package:produtoapp/widgets/historicoAbastecimento.dart';
import 'package:produtoapp/widgets/listagemVeiculos.dart';
import 'package:produtoapp/widgets/perfil.dart';
import 'package:produtoapp/widgets/recuperarSenha.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final VeiculoRepository _repository = VeiculoRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Veículos',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => AutenticacaoUser(),
        '/listagem': (context) => ListagemVeiculos(),
        '/meus-veiculos': (context) => ListagemVeiculos(),
        '/adicionar-veiculo': (context) =>
            CadastroVeiculo(repository: _repository),
        '/historico-abastecimentos': (context) => HistoricoAbastecimentoScreen(),
        '/perfil': (context) => Perfil(),
        'recuperar-senha': (context) => RecuperacaoSenha()
      },
    );
  }
}
