import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vibewithweather/data/services/weather_service.dart';
import 'package:vibewithweather/presentation/pages/weather_tune_page.dart';

import '../../bloc/forecast/forecast_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../domain/repositories/weather_repository.dart';
import 'forecast_page.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  String getWeatherAnimation(String? condition) {
    if (condition == null) return 'assets/Weather-sunny.json';

    switch (condition.toLowerCase()) {
      case 'thunderstorm':
        return 'assets/Weather-storm.json';
      case 'drizzle':
      case 'rain':
        return 'assets/rainy icon.json';
      case 'snow':
        return 'assets/Snowing.json';
      case 'clear':
        return 'assets/Weather-sunny.json';
      case 'clouds':
        return 'assets/Weather-windy.json';
      default:
        return 'assets/Weather-sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      /// ☰ HIDDEN DRAWER
      drawer: Drawer(
        backgroundColor: Colors.grey.shade900,
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'VIBE MENU',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Weather that matches your mood',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            _drawerItem(
              icon: Icons.graphic_eq,
              title: 'Weather Tune',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const WeatherTunePage(),
                    ),
                );
              },
            ),

            _drawerItem(
              icon: Icons.style,
              title: 'Your Style',
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to Theme / Style Page
              },
            ),


            const Divider(color: Colors.grey),

            _drawerItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFEEEEEE),
                Color(0xFFBDBDBD),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'VIBE WITH WEATHER',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black,
          ),
        ),
      ),

      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading || state is WeatherInitial) {
              return const CircularProgressIndicator();
            }

            if (state is WeatherLoaded) {
              final weather = state.weather;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weather.cityName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Lottie.asset(
                    getWeatherAnimation(weather.condition),
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${weather.temperature.round()} °C',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    weather.condition,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              );
            }

            if (state is WeatherError) {
              return Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              );
            }

            return const SizedBox();
          },
        ),
      ),

      floatingActionButton: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is! WeatherLoaded) {
            return const SizedBox();
          }

          final cityName = state.weather.cityName;

          return FloatingActionButton(
            backgroundColor: Colors.grey.shade800,
            child: const Icon(Icons.auto_awesome, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) => ForecastBloc(
                      context.read<WeatherService>(),
                    )..add(FetchForecast(cityName)),
                    child: ForecastPage(cityName: cityName),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// 🔘 Drawer Item Widget
  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade300),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
