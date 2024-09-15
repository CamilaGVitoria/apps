import 'dart:io';
import 'package:app_anuncios/model/anuncio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CadastroPage extends StatefulWidget {
  final Anuncio? anuncio;
  const CadastroPage({Key? key, this.anuncio});

  @override
  State<CadastroPage> createState() => _CadastroPage();
}

class _CadastroPage extends State<CadastroPage> {
  final TextEditingController _nomeControler = TextEditingController();
  final TextEditingController _informacoesControler = TextEditingController();
  final TextEditingController _precoControler = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.anuncio != null) {
      setState(() {
        _nomeControler.text = widget.anuncio!.nome;
        _informacoesControler.text = widget.anuncio!.informacoes;
        _precoControler.text = widget.anuncio!.preco;
        _image = widget.anuncio!.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Anuncio? _anuncio = widget.anuncio;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          _anuncio == null ? 'Cadastro' : 'Editar',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          GestureDetector(
            child: Container(
                width: 100,
                height: 120,
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  shape: BoxShape.circle,
                ),
                child: _image == null
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 30,
                      )
                    : ClipOval(
                        child: Image.file(_image!),
                      )),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? pickedFile =
                  await _picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                File image = File(pickedFile.path);
                Directory directory = await getApplicationDocumentsDirectory();
                String _localPath = directory.path;
                String uniqueID = UniqueKey().toString();

                final File savedImage =
                    await image.copy('$_localPath/$uniqueID.png');
                setState(() {
                  _image = savedImage;
                });
              }
            },
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: TextFormField(
                    controller: _nomeControler,
                    validator: (value) {
                      if (value!.isEmpty) return 'Preenchimento obrigatório';
                    },
                    decoration: const InputDecoration(
                      label: Text('Digite o nome do anúncio'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: TextFormField(
                    controller: _informacoesControler,
                    validator: (value) {
                      if (value!.isEmpty) return 'Preenchimento obrigatório';
                    },
                    decoration: const InputDecoration(
                      label: Text('Digite as informações do anúncio'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: TextFormField(
                    controller: _precoControler,
                    validator: (value) {
                      if (value!.isEmpty) return 'Preenchimento obrigatório';
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Digite o preço do anunciado'),
                      prefixText: 'R\$',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 190,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            Anuncio anuncio = Anuncio(
                              _nomeControler.text,
                              _informacoesControler.text,
                              _precoControler.text,
                              _image!,
                            );

                            if(widget.anuncio != null){
                              anuncio.id = widget.anuncio!.id;
                            }
                            
                            Navigator.pop(context, anuncio);
                          }
                        },
                        child: const Text(
                          'Salvar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 190,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
