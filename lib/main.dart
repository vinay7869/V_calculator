import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:v_calculator/mythemes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationsize = 38;
  double resultsize = 48;

  void buttonpressed(String btnval) {
    setState(() {
      if (btnval == 'CN') {
        equation = '0';
        result = '0';
        equationsize = 38;
        resultsize = 48;
      } else if (btnval == 'DEL') {
        equationsize = 48;
        resultsize = 38;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (btnval == '=') {
        equationsize = 38;
        resultsize = 48;
        expression = equation;
        expression = expression.replaceAll('x', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (result.contains('.') &&
              double.parse(result) == double.parse(result).toInt()) {
            result = double.parse(result).toInt().toString();
          }
        } catch (e) {
          result = 'Error';
        }
      } else {
        equationsize = 48;
        resultsize = 38;
        if (equation == '0') {
          equation = btnval;
        } else {
          equation = equation + btnval;
        }
      }
    });
  }

  Widget myButtons(String btnval, Color? btnclr, Color txtclr) {
    return MaterialButton(
      color: btnclr,
      padding: const EdgeInsets.all(22),
      shape: const CircleBorder(),
      splashColor: Colors.blue,
      onPressed: () => buttonpressed(btnval),
      child: Text(btnval,
          style: TextStyle(
              color: txtclr, fontWeight: FontWeight.bold, fontSize: 21)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('V - Calculator!',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).primaryColor,
                fontSize: 27)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(17),
            child: Text(equation, style: TextStyle(fontSize: equationsize)),
          )),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(17),
            child: Text(result, style: TextStyle(fontSize: resultsize)),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              myButtons('CN', Colors.grey[850], Colors.red),
              myButtons('DEL', Colors.grey[850], Colors.red),
              myButtons('%', Colors.grey[850], Colors.blue),
              myButtons('/', Colors.grey[850], Colors.blue),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              myButtons('7', Colors.grey[850], Colors.white),
              myButtons('8', Colors.grey[850], Colors.white),
              myButtons('9', Colors.grey[850], Colors.white),
              myButtons('x', Colors.grey[850], Colors.blue),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              myButtons('4', Colors.grey[850], Colors.white),
              myButtons('5', Colors.grey[850], Colors.white),
              myButtons('6', Colors.grey[850], Colors.white),
              myButtons('-', Colors.grey[850], Colors.blue),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              myButtons("1", Colors.grey[850], Colors.white),
              myButtons("2", Colors.grey[850], Colors.white),
              myButtons("3", Colors.grey[850], Colors.white),
              myButtons('+', Colors.grey[850], Colors.blue),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              myButtons('00', Colors.grey[850], Colors.white),
              myButtons('0', Colors.grey[850], Colors.white),
              myButtons('.', Colors.grey[850], Colors.white),
              myButtons('=', Colors.grey[850], Colors.blue),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
