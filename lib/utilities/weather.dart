class Weather {
  final String cityname;
  final String mainCondition;
  final double temperature;

  final double humidity;
  final double feels_like;
  final double temp_min;
  final double temp_max;
  final double? pressure;
  final double windspeed;
  final int timezone;

  Weather(
      {required this.cityname,
      required this.mainCondition,
      required this.temperature,
      required this.humidity,
      required this.feels_like,
      required this.temp_max,
      required this.temp_min,
      required this.pressure,
      required this.windspeed,
      required this.timezone});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityname: json['name'],
      mainCondition: json['weather'][0]['main'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'].toDouble(),
      feels_like: json['main']['feels_like'].toDouble(),
      temp_max: json['main']['temp_max'].toDouble(),
      temp_min: json['main']['temp_min'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      windspeed: json['wind']['speed'].toDouble(),
      timezone: json['timezone'],
    );
  }
}
