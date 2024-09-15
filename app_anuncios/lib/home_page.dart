import 'package:app_anuncios/anuncio_helper.dart';
import 'package:flutter/material.dart';
import 'package:app_anuncios/model/anuncio.dart';
import 'package:app_anuncios/cadastro_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Anuncio> anuncios = List.empty(growable: true);
  final AnuncioHelper _helper = AnuncioHelper();

  @override
  void initState() {
    super.initState();

    _helper.getAll().then((data) {
      setState(() {
        if (data != null) anuncios = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anúncios',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              Anuncio _anuncio = anuncios[index];
              return Dismissible(
                key: GlobalKey(),
                onDismissed: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    Anuncio editarAnuncio = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastroPage(anuncio: _anuncio),
                      ),
                    );

                    var result = await _helper.editAnuncio(editarAnuncio);

                    if (_anuncio != null) {
                      setState(() {
                        anuncios.removeAt(index);
                        anuncios.insert(index, editarAnuncio);
                      });
                    } 
                    return Future(() => false);
                  }else if (direction == DismissDirection.endToStart) {
                      var result =
                          await _helper.deleteAnuncio(_anuncio);

                      if (result != null) {
                        setState(() {
                          anuncios.removeAt(index);
                          
                        });
                      }
                       return Future(() => true);
                    }
                },
                secondaryBackground: Container(
                  color: Colors.red,
                  child: const Align(
                    alignment: Alignment(0.9, 0.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                background: Container(
                  color: Colors.green,
                  child: const Align(
                    alignment: Alignment(-0.9, 0.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Container(
                  child: Card(
                    child: ListTile(
                      leading: _anuncio.image != null
                          ? CircleAvatar(
                              child: ClipOval(
                                child: Image.file(_anuncio.image!),
                              ),
                            )
                          : const SizedBox(),
                      title: Text(_anuncio.nome),
                      subtitle: Text(_anuncio.informacoes),
                      trailing: Text(
                        'R\$${_anuncio.preco}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      onLongPress: () async {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.email),
                                    title: Text('Enviar por e-mail'),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Anuncio anuncio = anuncios[index];

                                      final uri = Uri(
                                        scheme: 'mailto',
                                        path: 'camilagvitoria1@gmail.com',
                                        queryParameters: {
                                          
                                        },
                                      );

                                      final url = uri.toString();
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        print('Erro ao enviar e-mail');
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.sms),
                                    title: Text('Enviar por SMS'),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Anuncio anuncio = anuncios[index];

                                      final uri = Uri(
                                        scheme: 'sms',
                                        path: '+55 62 984273832',
                                        queryParameters: {
                                          'subject': _anuncio.nome,
                                          'body': '${_anuncio.image}  ${_anuncio.informacoes} R\$${_anuncio.preco}'
                                        },
                                      );

                                      final url = uri.toString();
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        print('Erro ao enviar sms');
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.phone_android),
                                    title: Text('Enviar por Whatsapp'),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Anuncio anuncio = anuncios[index];

                                      final uri = Uri(
                                        scheme: 'whatsapp',
                                        path: '',
                                        queryParameters: {
                                          'subject': _anuncio.nome,
                                          'body': '${_anuncio.image}  ${_anuncio.informacoes} R\$${_anuncio.preco}'
                                        },
                                      );

                                      final url = uri.toString();
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        print('Erro ao enviar whatsapp');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            itemCount: anuncios.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Anuncio? anuncio = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroPage()),
          );

          Anuncio? savedAnuncio = await _helper.saveAnuncio(anuncio!);

          if (savedAnuncio != null) {
            setState(() {
              anuncios.add(savedAnuncio);
            });
          }
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
