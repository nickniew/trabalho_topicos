import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trabalho_topicos/model/Usuario.dart';


class usuarioHelper {
  static final usuarioHelper _instance = usuarioHelper._interno();

  factory usuarioHelper() => _instance;

  usuarioHelper._interno();

  Database? _banco;

  Future<Database> get banco async {
    if(_banco != null){
      return _banco!;
    } else {
      _banco = await iniciarBanco();
      return _banco!;
    }
  }
  String tabelaUsuario = "Usuario";

  Future<Database> iniciarBanco() async {
    final caminhoBanco = await getDatabasesPath();
    final caminho = join(caminhoBanco, "SisTopicos.db");
    const versao = 1;
    String sqlCriarBanco =
        "CREATE TABLE $tabelaUsuario("
    "${UsuarioPropriedades.id} INTEGER PRIMARY KEY ,"
    "${UsuarioPropriedades.email} VARCHAR , "
    "${UsuarioPropriedades.nome} VARCHAR , "
    "${UsuarioPropriedades.senha} VARCHAR "
    ")";
    String destruirBanco = "DROP TABLE $tabelaUsuario";

    return openDatabase(
      caminho,
      version: versao,
      onCreate: (banco, versaoNova) async {
        print("Criando banco com versão $versaoNova");
        await banco.execute(sqlCriarBanco);
      },
      onUpgrade: (banco, versaoAntiga, versaoNova) async {
        print("Atualizando banco da versão $versaoAntiga"
        " para versão $versaoNova");
        await banco.execute(destruirBanco);
        await banco.execute(sqlCriarBanco);
      },
    );
  }

  Future<Usuario> saveUser(Usuario usuario) async {
    Database bancoUsuario = await banco;
    usuario.id = await bancoUsuario.insert(tabelaUsuario, usuario.toMap());
    return usuario;
  }

  Future<Usuario> getUser(int id) async {
    Database bancoUsuario = await banco;
    List<Map> retorno = await bancoUsuario.query(tabelaUsuario,
    columns: [
      UsuarioPropriedades.id,
      UsuarioPropriedades.nome,
      UsuarioPropriedades.email,
      UsuarioPropriedades.senha
    ],
    where: "${UsuarioPropriedades.id} = ?",
    whereArgs: [id]);
    if (retorno.isNotEmpty){
      return Usuario.fromMap(retorno.first);
    } else {
      return null!;
    }
  }

  Future<List<Usuario>> getAllUser() async {
    Database bancoUsuario = await banco;
List<Map> retorno = await bancoUsuario.rawQuery("SELECT * FROM $tabelaUsuario");
List<Usuario> usuarios = [];
for (Map usuario in retorno) {
  usuarios.add(Usuario.fromMap(usuario));
}
return usuarios;
  }

  Future<int> updateUser(Usuario usuario) async {
    Database bancoUsuario = await banco;
    return await bancoUsuario.update(tabelaUsuario, usuario.toMap(),
    where: "${UsuarioPropriedades.id} = ?", whereArgs: [usuario.id]);
  }

  Future<int> removeUser(int id) async {
    Database bancoUsuario = await banco;
  return await bancoUsuario.delete(tabelaUsuario,
  where: "${UsuarioPropriedades.id} = ?", whereArgs: [id]);
  }

  Future<bool> login (String email, String senha)async {
    Database bancoUsuario = await banco;
    List<Map> retorno = await bancoUsuario.query(tabelaUsuario,
    where:
    "${UsuarioPropriedades.email} = ?"
    " AND "
    "${UsuarioPropriedades.senha} = ?",
    whereArgs: [email,senha]);
    if (retorno.isNotEmpty){
      return true;
    }
    return false;
  }
}