import 'dart:io';

class Anuncio {
  int? id;
  late String nome;
  late String informacoes;
  late String preco;
  File? image;
  
  Anuncio(this.nome, this.informacoes, this.preco, this.image);

  Anuncio.fromMap(Map map) {
    this.id = map['id'];
    this.nome = map['nome'];
    this.informacoes = map['informacoes'];
    this.preco = map['preco'];
    this.image = map['imagePath'] != '' ? File(map['imagePath']) : null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id' : this.id,
      'nome': this.nome,
      'informacoes': this.informacoes,
      'preco': this.preco,
      'imagePath': this.image != null ? this.image!.path : ''
    };
    return map;
  }

  @override
  String toString() {
    return 'Task(id: $id, nome: $nome, informacoes: $informacoes, preco: $preco, image: $image)';
  }
}
