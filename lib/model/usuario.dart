class Usuario {
  String? id;
  String? username;
  String? senha;

  Usuario({
    this.id,
    required this.username,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'senha': senha,
    };
  }

  // Converte de Firestore para objeto Usuario
  static Usuario fromMap(Map<String, dynamic> map, String id) {
    return Usuario(
      id: id,
      username: map['username'] ?? '',
      senha: map['senha'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Usuario{id: $id, username: $username, senha: $senha}';
  }
}
