import 'apis/current_weather_api.dart';
import 'apis/geo_code_api.dart';

import 'models/city_spec.dart';
import 'models/current_weather.dart';

import 'package:flutter/material.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherHome(),
    );
  }
}

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  String _city = '';
  Map<String, dynamic>? _weatherData;

  Future<void> _fetchWeather() async {
    if (_city.isEmpty) {
      return;
    }
    List<CitySpec> cities = await GeoCodeApi().fetchCities(city: (_city));

    if (cities.isEmpty) {
      return;
    }

    CitySpec firstCity = cities.first;

    double latitude = firstCity.latitude;
    double longitude = firstCity.longitude;
    String timezone = firstCity.timezone;

    CurrentWeather current_weather = await CurrentWeatherApi()
        .fetchCurrentWeather(
            latitude: latitude, longitude: longitude, timezone: timezone);

    setState(() {
      _weatherData = {
        'temperature': current_weather.temperature,
        'wind_speed': current_weather.wind_speed,
        'weather_code': current_weather.weather_code,
        'precipitation_sum': current_weather.precipitation_sum,
        'precipitation_probability_max':
            current_weather.precipitation_probability_max,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previsão do Tempo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Cidade'),
              onChanged: (value) => _city = value,
            ),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Buscar'),
            ),
            if (_weatherData != null)
              Column(
                children: [
                  Text('Temperatura: ${_weatherData!['temperature']}°C'),
                  Text(
                      'Velocidade do Vento: ${_weatherData!['wind_speed']} km/h'),
                  Text('Código do Clima: ${_weatherData!['weather_code']}'),
                  Text(
                      'Precipitação: ${_weatherData!['precipitation_sum']} mm'),
                  Text(
                      'Probabilidade Máxima de Precipitação: ${_weatherData!['precipitation_probability_max']}%'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
