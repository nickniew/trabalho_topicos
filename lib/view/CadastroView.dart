import 'package:flutter/material.dart';
import 'package:trabalho_topicos/helper/UsuarioHelper.dart';
import 'package:trabalho_topicos/view/LoginView.dart';
import '../model/Usuario.dart';

class Cadastro extends StatelessWidget {

  usuarioHelper facadeUser = usuarioHelper();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final _validKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext contexto) {
    return Scaffold(
      key: _validKey,
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              alignment: Alignment(0.0, 1.15),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("http://cdn.onlinewebfonts.com/svg/img_311846.png"),
                fit: BoxFit.fitHeight,
                ),
              ),
              child: Container(
                height: 56,
                width: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1.0],
                    colors: [
                      Color(0xFF01579B),
                      Color(0XFF607D8B),
                    ],
                  ),
                  border: Border.all(
                    width: 4.0,
                    color: const Color(0xFFFFFFFF),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(56),
                  ),
                ),
                child: SizedBox.expand(
                  child: ElevatedButton(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: (){},
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
               "Cadastrar",
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 color: Colors.white,
                 fontSize: 20,
               ),
               textAlign: TextAlign.center,
             ),
                onPressed: () {
                 Usuario usuario = Usuario();
                 usuario.nome = _nomeController.text;
                 usuario.email = _emailController.text;
                 usuario.senha = _senhaController.text;
                 facadeUser.saveUser(usuario);
                 _nomeController.clear();
                 _emailController.clear();
                 _senhaController.clear();
                 Navigator.push(
                   contexto,
                   MaterialPageRoute(
                     builder: (contexto) => Login(),
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