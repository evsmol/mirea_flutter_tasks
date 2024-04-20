import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Начальный маршрут приложения
      initialRoute: '/',
      routes: {
        // Полная вертикальная навигация с использованием именованных маршрутов
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        // Горизонтальная навигация с использованием вложенных маршрутов
        '/third': (context) => ThirdScreen(),
        '/third/first': (context) => ThirdFirstScreen(),
        '/third/second': (context) => ThirdSecondScreen(),
      },
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    int charCount = inputText.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('1. Подсчёт символов'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Введите текст:'),
            TextField(
              onChanged: (text) {
                setState(() {
                  inputText = text;
                });
              },
            ),
            Text('Количество символов: $charCount'),
            ElevatedButton(
              onPressed: () {
                // Маршрутизированная навигация на второй экран
                Navigator.pushNamed(context, '/second');
              },
              child: Text('Перейти к «2. Подсчёт пробелов»'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    int spaceCount = inputText.split(' ').length - 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('2. Подсчёт пробелов'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Введите текст:'),
            TextField(
              onChanged: (text) {
                setState(() {
                  inputText = text;
                });
              },
            ),
            Text('Количество пробелов: $spaceCount'),
            ElevatedButton(
              onPressed: () {
                // Маршрутизированная навигация на третий экран
                Navigator.pushNamed(context, '/third');
              },
              child: Text('Перейти к «3. Подсчёт гласных и согласных»'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3. Подсчёт гласных и согласных'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Переход на экран подсчета согласных
                Navigator.pushNamed(context, '/third/first');
              },
              child: Text('Перейти к «3.1. Подсчёт согласных»'),
            ),
            ElevatedButton(
              onPressed: () {
                // Переход на экран подсчета гласных
                Navigator.pushNamed(context, '/third/second');
              },
              child: Text('Перейти к «3.2. Подсчёт гласных»'),
            ),
          ],
        ),
      ),
    );
  }
}


class ThirdFirstScreen extends StatefulWidget {
  @override
  _ThirdFirstScreenState createState() => _ThirdFirstScreenState();
}

class _ThirdFirstScreenState extends State<ThirdFirstScreen> {
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    int consonantCount = inputText.replaceAll(RegExp(r'[ауоыиэяюёеАУОЫИЭЯЮËЕ\s]'), '').length;
    return Scaffold(
      appBar: AppBar(
        title: Text('3.1. Подсчёт согласных'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Введите текст:'),
            TextField(
              onChanged: (text) {
                setState(() {
                  inputText = text;
                });
              },
            ),
            Text('Количество согласных: $consonantCount'),
            ElevatedButton(
              onPressed: () {
                // Возврат на предыдущий экран
                Navigator.pop(context);
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdSecondScreen extends StatefulWidget {
  @override
  _ThirdSecondScreenState createState() => _ThirdSecondScreenState();
}

class _ThirdSecondScreenState extends State<ThirdSecondScreen> {
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    int vowelCount = inputText.replaceAll(RegExp(r'[^ауоыиэяюёеАУОЫИЭЯЮËЕ]'), '').length;
    return Scaffold(
      appBar: AppBar(
        title: Text('3.2. Подсчёт гласных'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Введите текст:'),
            TextField(
              onChanged: (text) {
                setState(() {
                  inputText = text;
                });
              },
            ),
            Text('Количество гласных: $vowelCount'),
            ElevatedButton(
              onPressed: () {
                // Возврат на предыдущий экран
                Navigator.pop(context);
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}
