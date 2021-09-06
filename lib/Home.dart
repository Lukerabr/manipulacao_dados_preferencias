import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _textoSalvo = "Nada salvo!";

  TextEditingController _controllerCampo = TextEditingController();

  _salvar() async {

    String valorDigitado = _controllerCampo.text;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valorDigitado);

    print("operacao (Salvar): $valorDigitado");

  }

  _recuperar() async {

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo = prefs.getString("nome") ?? "Não existem dados para serem recuperados!";
    });

    print("operacao (Recuperar): $_textoSalvo");

  }

  _remover() async {

    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");

    String _textoExcluido = _textoSalvo;

    print("operacao (Removido): $_textoExcluido");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulação de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              _textoSalvo,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Digite algo"
              ),
              controller: _controllerCampo,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: _salvar,
                    child: Text("Salvar"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      textStyle: TextStyle(fontSize: 20)
                    )
                ),
                ElevatedButton(
                    onPressed: _recuperar,
                    child: Text("Recuperar"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontSize: 20)
                    )
                ),
                ElevatedButton(
                    onPressed: _remover,
                    child: Text("Remover"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontSize: 20)
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
