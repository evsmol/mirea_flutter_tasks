import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'text_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
          create: (context) => TextBloc(),
          child: FirstScreen(),
        ),
        '/second': (context) => BlocProvider(
          create: (context) => TextBloc(),
          child: SecondScreen(),
        ),
        '/third': (context) => ThirdScreen(),
        '/third/first': (context) => BlocProvider(
          create: (context) => TextBloc(),
          child: ThirdFirstScreen(),
        ),
        '/third/second': (context) => BlocProvider(
          create: (context) => TextBloc(),
          child: ThirdSecondScreen(),
        ),
      },
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('1. Подсчёт символов'),
      ),
      body: Center(
        child: BlocBuilder<TextBloc, TextState>(
          builder: (context, state) {
            final charCount = (state is TextUpdated) ? state.charCount : 0;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Введите текст:'),
                TextField(
                  onChanged: (text) {
                    context.read<TextBloc>().add(TextChanged(text));
                  },
                ),
                Text('Количество символов: $charCount'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  child: Text('Перейти к «2. Подсчёт пробелов»'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2. Подсчёт пробелов'),
      ),
      body: Center(
        child: BlocBuilder<TextBloc, TextState>(
          builder: (context, state) {
            final spaceCount = (state is TextUpdated) ? state.spaceCount : 0;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Введите текст:'),
                TextField(
                  onChanged: (text) {
                    context.read<TextBloc>().add(TextChanged(text));
                  },
                ),
                Text('Количество пробелов: $spaceCount'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/third');
                  },
                  child: Text('Перейти к «3. Подсчёт гласных и согласных»'),
                ),
              ],
            );
          },
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
                Navigator.pushNamed(context, '/third/first');
              },
              child: Text('Перейти к «3.1. Подсчёт согласных»'),
            ),
            ElevatedButton(
              onPressed: () {
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

class ThirdFirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3.1. Подсчёт согласных'),
      ),
      body: Center(
        child: BlocBuilder<TextBloc, TextState>(
          builder: (context, state) {
            final consonantCount = (state is TextUpdated) ? state.consonantCount : 0;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Введите текст:'),
                TextField(
                  onChanged: (text) {
                    context.read<TextBloc>().add(TextChanged(text));
                  },
                ),
                Text('Количество согласных: $consonantCount'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Назад'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ThirdSecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3.2. Подсчёт гласных'),
      ),
      body: Center(
        child: BlocBuilder<TextBloc, TextState>(
          builder: (context, state) {
            final vowelCount = (state is TextUpdated) ? state.vowelCount : 0;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Введите текст:'),
                TextField(
                  onChanged: (text) {
                    context.read<TextBloc>().add(TextChanged(text));
                  },
                ),
                Text('Количество гласных: $vowelCount'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Назад'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
