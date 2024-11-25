import 'package:cloud_firestore/cloud_firestore.dart';

class Abastecimento {
  final String? id;
  final String? veiculoId;
  final double quantidadeLitros;
  final int quilometragem;
  final DateTime data;

  Abastecimento({
    this.id,
    required this.veiculoId,
    required this.quantidadeLitros,
    required this.quilometragem,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'veiculoId': veiculoId,
      'quantidadeLitros': quantidadeLitros,
      'quilometragem': quilometragem,
      'data': data, 
    };
  }

  factory Abastecimento.fromMap(Map<String, dynamic> map, String id) {
    return Abastecimento(
      id: id,
      veiculoId: map['veiculoId'] as String?,
      quantidadeLitros: (map['quantidadeLitros'] as num).toDouble(),
      quilometragem: map['quilometragem'] as int,
      data: (map['data'] as Timestamp).toDate(),
    );
  }
}
