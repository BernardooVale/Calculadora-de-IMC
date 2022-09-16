import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//main feito por Bernardo Vale dos Santos Bento

void main() {
  runApp(const MaterialApp(
    home: paginaPrincipal(),
  ));
}

class paginaPrincipal extends StatefulWidget {
  const paginaPrincipal({Key? key}) : super(key: key);

  @override
  State<paginaPrincipal> createState() => _paginaPrincipalState();
}

class _paginaPrincipalState extends State<paginaPrincipal> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pesoControle = TextEditingController();
  TextEditingController alturaControle = TextEditingController();
  String _informacao = "";

  void _reiniciaDados(){

    pesoControle.text = "";
    alturaControle.text = "";
    _informacao = "";
    _formKey = GlobalKey<FormState>();

  }

  void _calculo(){

    setState(() {
      double altura = double.parse(alturaControle.text);
      double peso = double.parse(pesoControle.text) / 100;
      double imc = peso / (altura * altura);
      imc = imc * 1000000;

      if(imc < 18.6){
        _informacao = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.5 && imc < 24.9){
        _informacao = "Peso normal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 25 && imc < 29.9){
        _informacao = "Sobrepeso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 30 && imc < 34.9){
        _informacao = "Obesidade grau 1 (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 35 && imc < 29.9){
        _informacao = "Obesidade grau 2 (${imc.toStringAsPrecision(4)})";
      } else if(imc > 40){
        _informacao = "Obesidade grau 3 (${imc.toStringAsPrecision(4)})";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(onPressed: _reiniciaDados,
              icon: const Icon(Icons.refresh)),
        ],
      ),
      backgroundColor: Colors.black38,
      body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Icon(Icons.person_outline, size: 120.0, color: Colors.green,),
          TextFormField(
            keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            decoration: const InputDecoration(
              labelText: "Peso (kg)",
              labelStyle: TextStyle(color:  Colors.white70),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 25.0),
            controller: pesoControle,
              validator:(value){
                if(value!.isEmpty){
                  return "Insira seu peso";
                } else if(double.parse(value) > 500){
                  return "Peso muito alto";
                } else if(double.parse(value) < 1){
                  return "Peso muito baixo";
                }
              }
          ),
          TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color:  Colors.white70),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 25.0),
              controller: alturaControle,
              validator: (value){
                if(value!.isEmpty){
                  return "Insira seu altura";
                } else if(double.parse(value) > 300){
                  return "Altura muito alta";
                } else if(double.parse(value) < 1){
                  return "Altura muito baixa";
                }
              }
          ),
          Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: ElevatedButton(
            onPressed:(){
              if(_formKey.currentState!.validate()) {
                _calculo();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: const Size(250, 50),
            ),
            child: const Text("Resultado", style: TextStyle(color: Colors.white70,
                                     fontSize: 25.0),
            ),
          ),
          ),
            Text(_informacao, style: const TextStyle(color: Colors.white70,
                fontSize: 25.0),
          )
        ],
      ),
      ),
      ),
    );
  }
}
