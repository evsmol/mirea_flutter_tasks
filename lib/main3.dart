import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая работа №3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Практическая работа №3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '';
  int lettersCount = 0;
  int vowelsCount = 0;
  int consonantsCount = 0;

  void count() {
    lettersCount = text.length;
    vowelsCount = text.replaceAll(RegExp('[^ауоыиэяюёеАУОЫИЭЯЮËЕ]'), '').length;
    consonantsCount = text.replaceAll(RegExp('[^бвгджзйклмнпрстфхцчшщБВГДЖЗЙКЛМНПРСТФХЦЧШЩ]'), '').length;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) => text = value,
            ),
            const SizedBox(height: 20),
            Text('Количество символов: $lettersCount'),
            const SizedBox(height: 20),
            Text('Количество гласных: $vowelsCount'),
            const SizedBox(height: 20),
            Text('Количество согласных: $consonantsCount'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: count,
              child: const Text('Подсчитать'),
            ),
          ],
        ),
      ),
    );
  }
}
