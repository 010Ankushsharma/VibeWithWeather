import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather/weather_bloc.dart';
import 'data/services/weather_service.dart';
import 'presentation/pages/weather_page.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<WeatherService>(
      create: (_) => WeatherService(),
      child: BlocProvider(
        create: (context) => WeatherBloc(
          context.read<WeatherService>(),
        )..add(FetchWeatherEvent()),
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
