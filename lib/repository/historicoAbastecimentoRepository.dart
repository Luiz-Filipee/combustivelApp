import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/abastecimento.dart';

class HistoricoAbastecimentoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Abastecimento>> obterHistoricoAbastecimentos() async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      QuerySnapshot querySnapshot = await _db
          .collection('usuarios')
          .doc(userId)
          .collection('abastecimentos')
          .orderBy('data', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return Abastecimento(
          id: doc.id,
          veiculoId: data['veiculoId'],
          data: (data['data'] as Timestamp).toDate(),
          quantidadeLitros: data['quantidadeLitros'],
          quilometragem: data['quilometragem'],
        );
      }).toList();
    } catch (e) {
      throw Exception('Erro ao obter histórico de abastecimentos: $e');
    }
  }

  Future<void> adicionar(Abastecimento abastecimento) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await _db
          .collection('usuarios')
          .doc(userId)
          .collection('abastecimentos')
          .add({
        'veiculoId': abastecimento.veiculoId,
        'data': abastecimento.data,
        'quantidadeLitros': abastecimento.quantidadeLitros,
        'quilometragem': abastecimento.quilometragem,
      });
    } catch (e) {
      throw Exception('Erro ao adicionar abastecimento: $e');
    }
  }
}
