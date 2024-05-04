import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая работа №7',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _weather = "";
  final TextEditingController _controller = TextEditingController();

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final apiKey = '6de3f2d891d84d738c3121807240405';
    final url = 'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Ошибка загрузки погоды: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> saveLastWeather(String weatherData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_weather', weatherData);
  }

  Future<String?> loadLastWeather() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_weather');
  }

  void updateWeatherDisplay(Map<String, dynamic> weatherData) {
    final condition = weatherData['current']['condition']['text'];
    final tempC = weatherData['current']['temp_c'];
    final humidity = weatherData['current']['humidity'];
    final wind = weatherData['current']['wind_kph'];

    setState(() {
      _weather = 'Температура: $tempC°C\n'
          'Состояние: $condition\n'
          'Влажность: $humidity%\n'
          'Ветер: $wind kph';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Практическая работа №7"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Введите название города',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    try {
                      var responseData = await fetchWeather(_controller.text);
                      updateWeatherDisplay(responseData);
                      await saveLastWeather(json.encode(responseData));
                    } catch (e) {
                      setState(() {
                        _weather = "Ошибка загрузки погоды: $e";
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            _weather.isNotEmpty ? Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(_weather, style: TextStyle(fontSize: 18)),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}