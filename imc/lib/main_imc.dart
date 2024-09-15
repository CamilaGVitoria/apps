import 'package:flutter/material.dart';

class MainIMC extends StatefulWidget {
  @override
  State<MainIMC> createState() => _MainIMCState();
}

class _MainIMCState extends State<MainIMC> {
  final TextEditingController _peso = TextEditingController();
  final TextEditingController _altura = TextEditingController();
  String _resultado = '';
  var _imagem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cálculo de IMC'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 162, 193),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              height: 150,
              width: 150,
              child: Image.asset('images/principal.png'),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 5, left: 20, right: 20),
              child: TextField(
                controller: _peso,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Digite seu peso em Kilogramas"),
                  suffix: Text('Kg'),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 185, 208),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 20, left: 20, right: 20),
              child: TextField(
                controller: _altura,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Digite sua altura em metros"),
                  suffix: Text('m'),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 185, 208),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              height: 50,
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Calcular',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  double peso = double.parse(_peso.text);
                  double altura = double.parse(_altura.text);

                  double imc = peso / (altura * altura);

                  setState(() {
                    if (imc < 18.5) {
                      _resultado = 'Abaixo do peso';
                      _imagem = Image.asset('images/abaixo_do_peso.png');
                    } else if (imc >= 18.6 && imc <= 24.9) {
                      _resultado = 'Peso ideal (parabéns)';
                      _imagem = Image.asset('images/peso_ideal.png');
                    } else if (imc >= 25 && imc <= 29.4) {
                      _resultado = 'Levemente acima do peso';
                      _imagem = Image.asset('images/acima_do_peso.png');
                    } else if (imc >= 30 && imc <= 34.9) {
                      _resultado = 'Obesidade grau I';
                      _imagem = Image.asset('images/obesidade_um.png');
                    } else if (imc >= 35 && imc <= 39.9) {
                      _resultado = 'Obesidade grau II (severa)';
                      _imagem = Image.asset('images/obesidade_dois.png');
                    } else if (imc > 40) {
                      _resultado = 'Obesidade grau III (mórbida)';
                      _imagem = Image.asset('images/obesidade_tres.png');
                    }
                  });
                },
              ),
            ),
            Column(
              children: [
                Text('O cálculo do IMC resultou em: $_resultado'),
                if (_imagem != null) Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 130,
                  width: 130,
                  child: _imagem,
                ),
              ],
            )
          ],
        ));
  }
}
