import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/utilities/CONTAINER.dart';
import 'package:weather/utilities/weather.dart';
import 'package:weather/utilities/weather_fetch.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  Weather? _weather;
  TextEditingController cityController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _isSearching = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _suggestions = ['Bangalore', 'Chennai', 'Delhi', 'Mumbai'];
  List<String> _filteredSuggestions = [];
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: "Agency",
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent.shade200,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(seconds: 3),
      ),
    );
  }

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
    _animationController.forward();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _filteredSuggestions = _suggestions;
        });
      } else {
        setState(() {
          _filteredSuggestions = [];
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    cityController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> weatherfetching(String city) async {
    if (city.trim().isEmpty) {
      showSnackBar("Please enter a city name.");
      return;
    }

    setState(() {
      _isSearching = true;
      _weather = null;
      _filteredSuggestions = [];
    });

    try {
      final weather = await getWeather(city);
      if (mounted) {
        setState(() {
          _weather = weather;
          _isSearching = false;
          _animationController.reset();
          _animationController.forward();
        });
      }
    } catch (e) {
      print("Error: $e");
      if (mounted) {
        setState(() {
          _isSearching = false;
          _animationController.reset();
          _animationController.forward();
        });
        showSnackBar("City not found. Try again.");
      }
    }
  }

  String weatheranimation(String? mainCondition, int? timezoneOffsetInSeconds) {
    if (mainCondition == null || timezoneOffsetInSeconds == null) {
      return 'assets/sunny.json'; // Fallback
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          focusNode: _focusNode,
                          controller: cityController,
                          cursorColor: const Color(0xFFF2DE9B),
                          style: const TextStyle(
                            fontFamily: "Agency",
                            fontSize: 48,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFF2DE9B),
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter city",
                            hintStyle: TextStyle(
                              color: Colors.white38,
                              fontFamily: "Agency",
                              fontSize: 48,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _filteredSuggestions = _suggestions
                                  .where((city) => city
                                      .toLowerCase()
                                      .startsWith(value.toLowerCase()))
                                  .toList();
                            });
                          },
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              weatherfetching(value.trim());
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                        if (_filteredSuggestions.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFF2DE9B),
                                width: 0.2,
                              ),
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: _filteredSuggestions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    _filteredSuggestions[index],
                                    style: TextStyle(
                                      fontFamily: "Agency",
                                      fontSize: 28,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  onTap: () {
                                    cityController.text =
                                        _filteredSuggestions[index];
                                    _filteredSuggestions.clear();
                                    FocusScope.of(context).unfocus();
                                    weatherfetching(cityController.text);
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_isSearching)
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(
                        color: Color(0xFFF2DE9B),
                        strokeWidth: 4,
                      ),
                    ),
                  if (_weather != null)
                    Column(
                      children: [
                        Lottie.asset(
                          weatheranimation(
                              _weather?.mainCondition, _weather?.timezone),
                          height: 250,
                        ),
                        Text(
                          "${_weather?.mainCondition ?? ""} ${_weather?.temp_min.round()}°/${_weather?.temp_max.round()}°",
                          style: const TextStyle(
                            fontFamily: "Orbitron",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${_weather?.temperature.round()}°C',
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
                              Value: _weather?.feels_like,
                              icon: Icons.device_thermostat,
                            ),
                            CONTAINER(
                              Title: 'Wind Speed',
                              Value: _weather?.windspeed,
                              icon: Icons.air_outlined,
                            ),
                            CONTAINER(
                              Title: 'Humidity',
                              Value: _weather?.humidity,
                              icon: Icons.water_drop,
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
