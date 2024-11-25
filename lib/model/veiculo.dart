class Veiculo{
  String? id;
  String? nome;
  String? modelo;
  String? ano;
  String? placa;

  Veiculo({
    this.id,
    required this.nome,
    required this.modelo,
    required this.ano,
    required this.placa
  });

  factory Veiculo.fromMap(Map<String, dynamic> map) {
    return Veiculo(id: map['id'], nome: map['nome'], modelo: map['modelo'], ano: map['ano'], placa: map['placa']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'modelo': modelo, 'ano': ano, 'placa': placa};
  }

  @override
  String toString() {
    return 'Veiculo{id: $id, nome: $nome, modelo: $modelo, ano: $modelo, ano: $ano, placa: $placa}';
  }
}