import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String palavra = "";
  String chave = "";
  final TextEditingController respostaController = TextEditingController();
  String mensagem = "";

  Map<String, String> palavras = {
    "COMPUTADOR": "APRENDIZADO",
    "CACHOEIRA": "MARAVILHOSO",
    "BANHEIRA": "FANTASIA",
    "BRIGADEIRO": "APRENDIZADO",
    "PRAIA": "FLORESTA",
    "FERIADO": "ALEGRIA",
    "FELICIDADE": "APRENDIZADO",
    "CAMILA": "AMIGOS",
    "LUCAS": "FELIZ"
  };

  void gerarPalavraEChave() {
    Random random = Random();
    int index = random.nextInt(palavras.length);
    palavra = palavras.keys.elementAt(index);
    chave = palavras[palavra]!;
  }

  String criptar(String palavra, String chave) {
    palavra = palavra.toUpperCase();
    chave = chave.toUpperCase();
    StringBuffer resultado = StringBuffer();

    for (int i = 0; i < palavra.length; i++) {
      var caracterePalavra = palavra[i];
      var caractereChave = chave[i % chave.length];
      int deslocamento = caractereChave.codeUnitAt(0) - 'A'.codeUnitAt(0);

      if (caracterePalavra.codeUnitAt(0) >= 65 && caracterePalavra.codeUnitAt(0) <= 90) {
        var ch = String.fromCharCode(((caracterePalavra.codeUnitAt(0) + deslocamento - 65) % 26) + 65);
        resultado.write(ch);
      } else {
        resultado.write(caracterePalavra);
      }
    }

    return resultado.toString();
  }

  @override
  void initState() {
    super.initState();
    gerarPalavraEChave();
  }

  void verificarResposta() {
    String respostaCifrada = criptar(palavra, chave);
    if (respostaController.text.toUpperCase() == respostaCifrada) {
      mensagem = "Parabéns! Você acertou.";
    } else {
      mensagem = "Errado! A resposta correta é $respostaCifrada.";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bom Jogo'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.deepOrange.shade100,
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              height: 400,
              width: 400,
              child: Image.asset('img/img.png'),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 30,
                    width: 70,
                    alignment: Alignment.center,
                    child: Text(
                      'Palavra: ',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 40,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      palavra,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    height: 30,
                    width: 70,
                    alignment: Alignment.center,
                    child: Text(
                      'Chave: ',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 40,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      chave,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextFormField(
                controller: respostaController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  label: Text(
                    'Digite aqui sua resposta de como ficaria a palavra encriptada',
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(),
                  fillColor: Colors.blue.shade900,
                  filled: true,
                ),
              ),
            ),
            Text(
              mensagem,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: verificarResposta,
                    child: const Text('Verificar'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        gerarPalavraEChave();
                        respostaController.clear();
                        mensagem = "";
                      });
                    },
                    child: const Text('Nova Palavra'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
