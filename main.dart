import 'package:flutter/material.dart';

void main() {
  runApp(MyCombinedApp());
}

class MyCombinedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPageView(),
    );
  }
}

class MyPageView extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          UsoDeBotones(),
          Contador(),
          Calculadora(),
        ],
      ),
    );
  }
}

class UsoDeBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uso de Botones'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UsoDeBotonesButton(color: Colors.red),
            SizedBox(height: 20),
            UsoDeBotonesButton(color: Colors.green),
            SizedBox(height: 20),
            UsoDeBotonesButton(color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class Contador extends StatefulWidget {
  @override
  _ContadorState createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int counter = 0;

  void increaseCounter() {
    setState(() {
      counter++;
    });
  }

  void decreaseCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador con Botones'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Contador: $counter',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ContadorButton(
              color: Colors.red,
              label: 'Aumentar',
              onPressed: increaseCounter,
            ),
            SizedBox(height: 20),
            ContadorButton(
              color: Colors.green,
              label: 'Disminuir',
              onPressed: decreaseCounter,
            ),
            SizedBox(height: 20),
            ContadorButton(
              color: Colors.blue,
              label: 'Limpiar',
              onPressed: resetCounter,
            ),
          ],
        ),
      ),
    );
  }
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String display = '';
  double num1 = 0;
  double num2 = 0;
  String operand = '';
  double resultado = 0;

  void onPressButton(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        display = '';
        num1 = 0;
        num2 = 0;
        operand = '';
        resultado = 0;
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        num1 = double.parse(display);
        operand = buttonText;
        display = '';
      } else if (buttonText == '=') {
        num2 = double.parse(display);
        switch (operand) {
          case '+':
            resultado = num1 + num2;
            break;
          case '-':
            resultado = num1 - num2;
            break;
          case '*':
            resultado = num1 * num2;
            break;
          case '/':
            resultado = num1 / num2;
            break;
        }
        display = resultado.toString();
        num1 = resultado;
        operand = '';
      } else if (buttonText == '+/-') {
        // Cambiar el signo del número actual en pantalla
        if (display != '' && display != '0') {
          display = (double.parse(display) * -1).toString();
        }
      } else if (buttonText == '%') {
        // Calcular el porcentaje del número actual en pantalla
        if (display != '' && display != '0') {
          double porcentaje = double.parse(display) / 100;
          display = porcentaje.toString();
        }
      } else {
        display += buttonText;
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onPressButton(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                display,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('/'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('*'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('-'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('0'),
              buildButton('C'),
              buildButton('+/-'),
              buildButton('%'),
              buildButton('='),
              buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }
}

class UsoDeBotonesButton extends StatelessWidget {
  final Color color;

  const UsoDeBotonesButton({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Lógica a ejecutar cuando se presiona el botón
        print('Botón de color ${color.toString()} presionado');
      },
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.all(20),
      ),
      child: Text(
        'Botón',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class ContadorButton extends StatelessWidget {
  final Color color;
  final String label;
  final VoidCallback onPressed;

  const ContadorButton({
    Key? key,
    required this.color,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.all(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
