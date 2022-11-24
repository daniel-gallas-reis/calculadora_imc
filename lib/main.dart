import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String info = 'Informe seus dados';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                _resetField();
                errorTexth = null;
                errorTextw = null;
              });
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.person_outline,
              size: 120,
              color: Colors.green,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: weightController,
              decoration: InputDecoration(
                errorText: errorTextw,
                labelText: 'Peso (Kg)',
                labelStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 25,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: heightController,
              decoration: InputDecoration(
                errorText: errorTexth,
                labelText: 'Altura (cm)',
                labelStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: (){
                errorTextDefine();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              child: const Text(
                'Calcular',
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              info,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.green, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void _resetField(){
    setState(() {
      weightController.clear();
      heightController.clear();
      info = 'Informe seus dados';
    });
  }

  String? errorTextw;
  String? errorTexth;

  void errorTextDefine(){
    setState(() {
      if(weightController.text.isEmpty && heightController.text.isEmpty){
        errorTextw = 'Parâmetro obrigatório!';
        errorTexth = 'Parâmetro obrigatório!';
      }else if(heightController.text.isEmpty){
        errorTexth = 'Parâmetro obrigatório!';
        errorTextw = null;
      }else if(weightController.text.isEmpty){
        errorTextw = 'Parâmetro obrigatório!';
        errorTexth = null;
      }
      else{
        errorTextw = null;
        errorTexth = null;
        calculateIMC();
      }
    });
  }

  void calculateIMC(){
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text)/100;
    double imc = weight/(height*height);
    setState(() {
      if (imc<18.6){
        info = 'Abaixo do peso ideal. IMC: ${imc.toStringAsPrecision(4)}';
      }else if(imc>25){
        info = 'Acima do Peso ideal. IMC: ${imc.toStringAsPrecision(4)}';
      }else{
        info = 'Peso ideal. IMC: ${imc.toStringAsPrecision(4)}';
      }
    });
  }

}
