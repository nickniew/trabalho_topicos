  import 'package:trabalho_topicos/view/LoginView.dart';
import 'package:flutter/material.dart';

  class barra extends StatelessWidget {
    @override
    Widget build(BuildContext contexto){
      Widget cancela = ElevatedButton(
        child: Text('Não'),
        onPressed: (){
          Navigator.of(contexto).pop();
        },
      );
      Widget confirma = ElevatedButton(
        child: Text('Sim'),
        onPressed: (){
          Navigator.push(
            contexto,
            MaterialPageRoute(
              builder: (contexto) => Login(),
            ),
          );
        },
      );
      AlertDialog sair = AlertDialog(
        title: Text('Deseja Sair?'),
        content: Text('Deseja mesmo sair do aplicativo?'),
        actions: [
          cancela,
          confirma,
        ],
      );
      return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text('nickniew.com'), 
                accountEmail: Text('nickniew@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network('https://i.pinimg.com/736x/2a/28/5a/2a285af8af62a57709571a27f88dabe7.jpg',
                   fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                 ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://i.pinimg.com/originals/d5/26/bb/d526bb65e677bee39422b683b2fffc47.jpg')
                ),
              ),
              ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favoritos'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Amigos'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Compartilhar'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Convites'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () => showDialog(
                  context: contexto,
                  builder: (BuildContext contexto){
                    return sair;
                  }),
            ),
          ],
        ),
      );
    }
}