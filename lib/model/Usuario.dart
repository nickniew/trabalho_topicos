class Usuario {

  int id = 0;
  String nome = '';
  String email = '';
  String senha = '';

  Usuario(){
  }

Usuario.fromMap(Map map){
  id = map[UsuarioPropriedades.id] ?? 0;
  nome = map[UsuarioPropriedades.nome];
  email = map[UsuarioPropriedades.email];
  senha = map[UsuarioPropriedades.senha];
}

Map<String, Object> toMap() {
  Map<String, Object> map = {
    UsuarioPropriedades.nome: nome,
    UsuarioPropriedades.email: email,
    UsuarioPropriedades.senha: senha,
  };
  if(id > 0){
    map[UsuarioPropriedades.id] = id;
  }
  return map;
}

}

class UsuarioPropriedades {
  static String id = "id";
  static String nome = "nome";
  static String email = "email";
  static String senha = "senha";
}