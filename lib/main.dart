import 'dart:convert';
import 'package:atividad_segundo_corte/perfilmensajero.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> listarPost(http.Client client) async {
  //final response =
  //    await client.get('https://desarolloweb2021a.000webhostapp.com/API/listarnotas.php');
  //var id = "2";
  final response = await http.get(Uri.parse(
      'https://desarolloweb2021a.000webhostapp.com/API/listarmensajeros.php'));

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListas, response.body);
}

// Una función que convierte el body de la respuesta en un List<Photo>
List<Post> pasaraListas(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Post>((json) => Post.fromJson(json)).toList();
}

class Post {
  final String id;
  final String nombre;
  final String foto;
  final String placa;
  final String telefono;
  final String whatsapp;
  final String moto;

  Post(
      {this.id,
      this.nombre,
      this.foto,
      this.placa,
      this.telefono,
      this.whatsapp,
      this.moto});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      nombre: json['nombre'],
      foto: json['foto'],
      placa: json['placa'],
      telefono: json['telefono'],
      whatsapp: json['whatsapp'],
      moto: json['moto'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MARIO MENDOZA RODRIGUEZ'),
      ),

      body: getInfo(context),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getInfo(context);
          });
        },
        tooltip: 'Refrescar',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget getInfo(BuildContext context) {
  return FutureBuilder(
    future: listarPost(http
        .Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? Vistamensajeros(posts: snapshot.data)
              : Text('Sin Datos');

        /*
             Text(
              snapshot.data != null ?'ID: ${snapshot.data['id']}\nTitle: ${snapshot.data['title']}' : 'Vuelve a intentar', 
              style: TextStyle(color: Colors.black, fontSize: 20),);
            */

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class Vistamensajeros extends StatelessWidget {
  final List<Post> posts;

  const Vistamensajeros({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts == null ? 0 : posts.length,
        itemBuilder: (context, posicion) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Perfilmensajero(
                          perfil: posts, idperfil: posicion)));
            },
            leading: Container(
              padding: EdgeInsets.all(5.0),
              width: 50,
              height: 50,
              child: Image.network(posts[posicion].foto),
            ),
            title: Text(posts[posicion].nombre),
            subtitle: Text(posts[posicion].moto),
            trailing: Container(
              width: 80,
              height: 40,
              color: Colors.yellowAccent,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(posts[posicion].placa),
            ),
          );
        });
  }
}
