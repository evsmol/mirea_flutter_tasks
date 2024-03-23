import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая работа №5',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PlatformHomePage(),
    );
  }
}

class PlatformHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Практическая работа №5'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Это приложение запущено на:',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Text(
              _getPlatformName(context),
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.0),
            _buildPlatformSpecificButton(context),
          ],
        ),
      ),
    );
  }

  String _getPlatformName(BuildContext context) {
    final platform = Theme.of(context).platform;
    if (kIsWeb) {
      return 'Web';
    } else if (platform == TargetPlatform.android) {
      return 'Android';
    } else if (platform == TargetPlatform.iOS) {
      return 'iOS';
    } else if (platform == TargetPlatform.windows) {
      return 'Windows';
    } else if (platform == TargetPlatform.macOS) {
      return 'macOS';
    } else if (platform == TargetPlatform.linux) {
      return 'Linux';
    } else if (platform == TargetPlatform.fuchsia) {
      return 'Fuchsia';
    } else {
      return 'Unknown Platform';
    }
  }

  Widget _buildPlatformSpecificButton(BuildContext context) {
    final platform = Theme.of(context).platform;
    if (kIsWeb) {
      return ElevatedButton(
        onPressed: () {
          _showWebAlert();
        },
        child: Text('Нажмите на веб-платформе'),
      );
    } else if (platform == TargetPlatform.android ||
        platform == TargetPlatform.iOS) {
      return ElevatedButton(
        onPressed: () {
          _showAlertDialog(context, 'Вы нажали на кнопку на Android или iOS.');
        },
        child: Text('Нажмите на Android или iOS'),
      );
    } else if (platform == TargetPlatform.windows ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.linux) {
      return ElevatedButton(
        onPressed: () {
          _showSnackBar(
              context, 'Вы нажали на кнопку на Windows, macOS или Linux.');
        },
        child: Text('Нажмите на Windows, macOS или Linux'),
      );
    } else {
      return Container();
    }
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Сообщение'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showWebAlert() {
    html.window.alert('Вы нажали на кнопку на веб-платформе.');
  }
}
