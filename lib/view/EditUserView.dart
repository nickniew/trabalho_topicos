import 'package:trabalho_topicos/helper/UsuarioHelper.dart';
import 'package:trabalho_topicos/model/Usuario.dart';
import 'package:trabalho_topicos/view/HomeView.dart';
import 'package:flutter/material.dart';

class Editar extends StatefulWidget {
  late Usuario usuario;
  Editar.withUser({required this.usuario});

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  usuarioHelper facadeUser = usuarioHelper();
  late int ident = 0;


  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.usuario.nome;
    _emailController.text = widget.usuario.email;
    _senhaController.text = widget.usuario.senha;
    ident = widget.usuario.id;
  }

  Widget build(BuildContext contexto) {

    return Scaffold(
      key: _formKey,
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _nomeController,
              keyboardType: TextInputType.text,
              validator: (nome){
                if(nome!.isEmpty)
                  return 'O nome deve ser preenchido';
                else
                  return null;
              },
              onSaved: (nome){
                _nomeController.text = nome!;
              },
              decoration: const InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (email){
                if(email!.isEmpty)
                  return 'O email deve ser preenchido';
                else
                  return null;
              },
              onSaved: (email){
                _emailController.text = email!;
              },
              decoration: const InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _senhaController,
              keyboardType: TextInputType.text,
              validator: (senha){
                if(senha!.isEmpty)
                  return 'A senha deve ser preenchida';
                else
                  return null;
              },
              onSaved: (senha){
                _senhaController.text = senha!;
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                  fontSize: 20
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color(0xFF01579B),
                    Color(0XFF607D8B),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: ElevatedButton(
                    child: const Text(
                      "Editar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      //             if(_validKey.currentState!.validate()){
                      Usuario usuario = Usuario();
                      usuario.id = ident;
                      usuario.nome = _nomeController.text;
                      usuario.email = _emailController.text;
                      usuario.senha = _senhaController.text;
                      facadeUser.updateUser(usuario);
                      _nomeController.clear();
                      _emailController.clear();
                      _senhaController.clear();
                      Navigator.push(
                        contexto,
                        MaterialPageRoute(
                          builder: (contexto) => Home(),
                        ),
                      );
                    }
                  //              },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: ElevatedButton(
                child: const Text(
                  "Cancelar",
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.pop(contexto, false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}