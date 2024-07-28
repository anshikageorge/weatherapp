import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = 'London';
  String temperature = '';
  String description = '';

  Future<void> fetchWeather() async {
    final apiKey = 'bbb1ec9aa61bb9861f553a84d3bbdc06'; // Replace with your OpenWeatherMap API key
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        temperature = data['main']['temp'].toString();
        description = data['weather'][0]['description'];
      });
    } else {
      setState(() {
        temperature = '';
        description = 'Could not fetch weather data';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter City Name',
              ),
              onChanged: (value) {
                cityName = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeather,
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20),
            if (temperature.isNotEmpty && description.isNotEmpty)
              Column(
                children: [
                  Text(
                    '$temperature°C',
                    style: TextStyle(fontSize: 32),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            if (temperature.isEmpty && description.isNotEmpty)
              Text(
                description,
                style: TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}
