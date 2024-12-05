class CurrentWeather {
  final double temperature;
  final double wind_speed;
  final int weather_code;
  final double precipitation_sum;
  final int precipitation_probability_max;

  CurrentWeather(
      {required this.precipitation_sum,
      required this.precipitation_probability_max,
      required this.temperature,
      required this.wind_speed,
      required this.weather_code});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      precipitation_sum: json['daily']['precipitation_sum'][0],
      precipitation_probability_max: json['daily']
          ['precipitation_probability_max'][0],
      temperature: json['current_weather']['temperature'],
      wind_speed: json['current_weather']['windspeed'],
      weather_code: json['current_weather']['weathercode'],
    );
  }
}
