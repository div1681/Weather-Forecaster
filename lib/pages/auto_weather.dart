import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/utilities/CONTAINER.dart';
import 'package:weather/utilities/weather.dart';
import 'package:weather/utilities/weather_fetch.dart';

class AutoWeather extends StatefulWidget {
  const AutoWeather({super.key});

  @override
  State<AutoWeather> createState() => _AutoWeatherState();
}

class _AutoWeatherState extends State<AutoWeather>
    with SingleTickerProviderStateMixin {
  String latLonText = "Getting location...";
  Weather? __weather;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    getLocation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> getLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final weather = await get_auto_Weather(
          position.latitude.toDouble(), position.longitude.toDouble());

      if (mounted) {
        setState(() {
          __weather = weather;
          _animationController.forward();
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  String weatheranimation(String? mainCondition, int? timezoneOffsetInSeconds) {
    if (mainCondition == null || timezoneOffsetInSeconds == null) {
      return 'assets/sunny.json';
    }

    final utcNow = DateTime.now().toUtc();
    final localTime = utcNow.add(Duration(seconds: timezoneOffsetInSeconds));

    final isNight = localTime.hour < 6 || localTime.hour > 18;

    if (isNight) {
      return 'assets/night.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'fog':
      case 'mist':
      case 'smoke':
      case 'dust':
      case 'haze':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF1E1E1E),
      body: __weather == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Color(0xFFF2DE9B),
                    strokeWidth: 4,
                  ),
                ],
              ),
            )
          : FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Container(
                    alignment: const Alignment(-0.9, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, left: 16),
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          __weather?.cityname ?? "wait",
                          style: const TextStyle(
                            fontFamily: "Agency",
                            fontSize: 48,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFF2DE9B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Lottie.asset(
                    weatheranimation(
                        __weather?.mainCondition, __weather?.timezone),
                    height: 250,
                  ),
                  Text(
                    "${__weather?.mainCondition ?? ""} ${__weather?.temp_min.round()}°/${__weather?.temp_max.round()}°",
                    style: const TextStyle(
                      fontFamily: "Orbitron",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${__weather?.temperature.round()}°C',
                    style: const TextStyle(
                      fontFamily: "Agency",
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFF2DE9B),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CONTAINER(
                        Title: "Feel's Like",
                        Value: __weather?.feels_like.toDouble(),
                        icon: Icons.device_thermostat,
                      ),
                      CONTAINER(
                        Title: 'Wind Speed',
                        Value: __weather?.windspeed.toDouble(),
                        icon: Icons.air_outlined,
                      ),
                      CONTAINER(
                        Title: 'Humidity',
                        Value: __weather?.humidity.toDouble(),
                        icon: Icons.water_drop,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
