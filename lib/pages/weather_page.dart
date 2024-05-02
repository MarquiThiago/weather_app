import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather/common/presentation/widgets/box_spacer.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('224bf533217c23093ba8cb16c3953775');
  Weather? _weather;

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 40, color: Colors.blueGrey.shade700),
            const BoxSpacer(),
            Text(_weather?.cityname ?? 'loading city...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                )),
            const BoxSpacer(
              size: 34,
            ),
            Image.asset(getWeatherImage(_weather?.condition)),
            const BoxSpacer(
              size: 34,
            ),
            const BoxSpacer(),
            Text(
              '${_weather?.temperature.round() ?? 0}°C',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchWeather() async {
    final city = await _weatherService.getcurrentCity();
    try {
      final weather = await _weatherService.getWeather(city);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  String getWeatherImage(String? mainCondition) {
    mainCondition ??= 'clear';
    switch (mainCondition.toLowerCase()) {
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'clouds':
      case 'dust':
      case 'fog':
        return "assets/cloudy.png";
      case 'thunderstorm':
        return "assets/storm.png";
      case 'shower rain':
      case 'drizzle':
      case 'rain':
        return "assets/rain.png";
      case 'clear':
        return "assets/suny.png";
      default:
        return "assets/storm.png";
    }
  }
}
