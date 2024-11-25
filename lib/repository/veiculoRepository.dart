import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:produtoapp/model/veiculo.dart';

class VeiculoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> adicionar(Veiculo veiculo) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await _db.collection('usuarios').doc(userId).collection('veiculos').add({
        'nome': veiculo.nome,
        'modelo': veiculo.modelo,
        'ano': veiculo.ano,
        'placa': veiculo.placa,
      });
    } catch (e) {
      throw Exception('Erro ao adicionar veículo: $e');
    }
  }

  Future<void> atualizar(Veiculo veiculo) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await _db
          .collection('usuarios')
          .doc(userId)
          .collection('veiculos')
          .doc(veiculo.id)
          .update({
        'nome': veiculo.nome,
        'modelo': veiculo.modelo,
        'ano': veiculo.ano,
        'placa': veiculo.placa,
      });
    } catch (e) {
      throw Exception("Erro ao atualizar veículo: $e");
    }
  }

  Future<void> deletar(Veiculo veiculo) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await _db
          .collection('usuarios')
          .doc(userId)
          .collection('veiculos')
          .doc(veiculo.id)
          .delete();
    } catch (e) {
      throw Exception("Erro ao deletar veículo: $e");
    }
  }

  Future<List<Veiculo>> obterTodos() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      QuerySnapshot querySnapshot = await _db
          .collection('usuarios')
          .doc(userId)
          .collection('veiculos')
          .get();

      return querySnapshot.docs.map((doc) {
        return Veiculo(
          id: doc.id,
          nome: doc['nome'],
          modelo: doc['modelo'],
          ano: doc['ano'],
          placa: doc['placa'],
        );
      }).toList();
    } catch (e) {
      throw Exception('Erro ao obter veículos: $e');
    }
  }

  Future<double> calcularMediaConsumo(String veiculoId) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      QuerySnapshot querySnapshot = await _db
          .collection('usuarios')
          .doc(userId)
          .collection('veiculos')
          .doc(veiculoId)
          .collection('abastecimentos')
          .orderBy('data')
          .get();

      List<DocumentSnapshot> abastecimentos = querySnapshot.docs;

      if (abastecimentos.isEmpty) {
        return 0.0;
      }

      double totalLitros = 0;
      int quilometragemAnterior = 0;
      double totalConsumo = 0;

      for (var abastecimento in abastecimentos) {
        double litros = abastecimento['quantidadeLitros'];
        int quilometragemAtual = abastecimento['quilometragem'];

        if (quilometragemAnterior != 0) {
          double consumo =
              (quilometragemAtual - quilometragemAnterior) / litros;
          totalConsumo += consumo;
        }

        quilometragemAnterior = quilometragemAtual;
        totalLitros += litros;
      }

      return totalConsumo / abastecimentos.length;
    } catch (e) {
      throw Exception('Erro ao calcular a média de consumo: $e');
    }
  }
}
