import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:produtoapp/model/usuario.dart';

class UsuarioRepository {
  final CollectionReference _usuariosCollection =
      FirebaseFirestore.instance.collection('usuarios');

  Future<void> adicionarUsuario(Usuario usuario) async {
    try {
      await _usuariosCollection.add(usuario.toMap());
    } catch (e) {
      throw Exception("Erro ao adicionar usuário: $e");
    }
  }

  Future<void> atualizarUsuario(Usuario usuario) async {
    if (usuario.id == null) {
      throw Exception("Usuário sem ID não pode ser atualizado");
    }

    try {
      await _usuariosCollection.doc(usuario.id).update(usuario.toMap());
    } catch (e) {
      throw Exception("Erro ao atualizar usuário: $e");
    }
  }

  Future<void> deletarUsuario(String id) async {
    try {
      await _usuariosCollection.doc(id).delete();
    } catch (e) {
      throw Exception("Erro ao deletar usuário: $e");
    }
  }

  Future<List<Usuario>> obterTodosUsuarios() async {
    try {
      QuerySnapshot querySnapshot = await _usuariosCollection.get();
      return querySnapshot.docs.map((doc) {
        return Usuario.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception("Erro ao obter usuários: $e");
    }
  }

  Future<Usuario> obterUsuarioPorId(String id) async {
    try {
      DocumentSnapshot doc = await _usuariosCollection.doc(id).get();
      if (!doc.exists) {
        throw Exception("Usuário com ID $id não encontrado.");
      }
      return Usuario.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      throw Exception("Erro ao obter usuário: $e");
    }
  }
}