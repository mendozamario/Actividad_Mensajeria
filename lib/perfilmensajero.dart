import 'package:flutter/material.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';

class Perfilmensajero extends StatelessWidget {
  final idperfil;
  final List<Post> perfil;
  Perfilmensajero({Key key, this.perfil, this.idperfil});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('MARIO MENDOZA RODRIGUEZ'),
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            height: 460,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    left: (MediaQuery.of(context).size.width / 2) - 55,
                    child: Container(
                      height: 100,
                      width: 100,
                      //color: Colors.blue,
                      child: Card(
                        elevation: 2,
                        child: Image.network(perfil[idperfil].foto),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Text(
                                perfil[idperfil].nombre,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(perfil[idperfil].moto),
                             
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.phone), 
                                        onPressed: (){
                                          launchPhone(perfil[idperfil].telefono, context);
                                        }
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.textsms), 
                                        onPressed: (){
                                          launchWhatsApp(perfil[idperfil].whatsapp, context);
                                        }
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              
                              SizedBox(
                                height: 20,
                              ),
                              Text('Calificaciones'),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('Cumplimiento'),
                                      CircleAvatar(child: Text('0.0')),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Responsabilidad'),
                                      CircleAvatar(child: Text('0.0')),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Amabilidad'),
                                      CircleAvatar(child: Text('0.0')),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Descripcion:'),
                              Text('Mensajero las 24 Horas'),
                              SizedBox(height: 20),
                              SizedBox(height: 20),
                              Text('Verificar Placa:'),
                              SizedBox(height: 10),
                              Container(
                                width: 100,
                                height: 50,
                                color: Colors.yellowAccent,
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(
                                  perfil[idperfil].placa,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Regresar'))
        ]),
      ),
    );
  }
}

void launchWhatsApp(String whatsapp, BuildContext context) async{
  String url = 'whatsapp://send?text=sample text&phone=+57 $whatsapp';

  await canLaunch(url) ? launch(url) : showDialog(context: context, builder: (_) => AlertDialog(
    title: Text('Error'),
    content: Text('No se pudo redirigir a la opción deseada'),
    actions: [
      TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Aceptar', style: TextStyle(color: Colors.blue)))
    ],
  ));
}

void launchPhone(String telefono, BuildContext context) async{
  String url = 'tel://$telefono';

  await canLaunch(url) ? launch(url) : showDialog(context: context, builder: (_) => AlertDialog(
    title: Text('Error'),
    content: Text('No se pudo redirigir a la opción deseada'),
    actions: [
      TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Aceptar', style: TextStyle(color: Colors.blue)))
    ],
  ));
}