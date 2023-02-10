import 'package:trabalho_topicos/helper/UsuarioHelper.dart';
import 'package:trabalho_topicos/model/Usuario.dart';
import 'package:trabalho_topicos/view/BarraView.dart';
import 'package:trabalho_topicos/view/EditUserView.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  usuarioHelper facadeUser = usuarioHelper();

  Widget build(BuildContext contexto) {
    BuildContext context = contexto;
    return Scaffold(
      drawer: barra(),
      appBar: barraSuperior(),
      body: corpo(context),
    );
  }

  barraSuperior() {
    return AppBar(
      title: Text("Home"),
    );
  }

  corpo(context) {
    return Column(
      children: [listaJogadores(context)],
    );
  }

  listaJogadores(context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(15),
        child: FutureBuilder<List<Usuario>>(
          future: loadListaUsuario(),
          builder: (contexto, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return buildListaUsuario(snapshot.data!,context);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  buildListaUsuario(List<Usuario> usuarios, context) {
    return ListView.builder(
      itemCount: usuarios.length,
      itemBuilder: (contexto, index) {
        return usuarioDaLista(usuarios[index], index, context);
      },
    );
  }

  usuarioDaLista(Usuario usuario, int index, context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(
        usuario.nome,
        style: const TextStyle(fontSize: 20),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Editar.withUser(usuario: usuario),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState(() {
                facadeUser.removeUser(usuario.id);
              });
            },
          ),
        ],
      ),
    );
  }

  Future<List<Usuario>> loadListaUsuario() async {
    List<Usuario> lista = [];
    await Future.delayed(const Duration(seconds: 3));
    lista = await facadeUser.getAllUser();
    return lista;
  }

}