import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/forecast/forecast_bloc.dart';
import '../../data/models/forecast_model.dart';
import '../../utils/forecast_helper.dart';

class ForecastPage extends StatelessWidget {
  final String cityName;

  const ForecastPage({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$cityName Forecast'),
        centerTitle: true,
      ),
      body: BlocBuilder<ForecastBloc, ForecastState>(
        builder: (context, state) {
          if (state is ForecastLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ForecastLoaded) {
            final dailyForecast = filterDailyForecast(state.forecast);
            return _buildForecastList(dailyForecast);
          }

          if (state is ForecastError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }

  /// 📅 Date formatter
  String formatDate(DateTime date) {
    return DateFormat('EEE • hh a').format(date);
  }

  /// 🌦 Weather asset mapper
  String getWeatherAsset(String condition) {
    switch (condition.toLowerCase()) {
      case 'rain':
      case 'drizzle':
        return 'assets/rainy icon.json';
      case 'clouds':
        return 'assets/Weather-windy.json';
      case 'snow':
        return 'assets/Snowing.json';
      case 'thunderstorm':
        return 'assets/Weather-storm.json';
      case 'clear':
      default:
        return 'assets/Weather-sunny.json';
    }
  }

  Widget _buildForecastList(List<ForecastModel> forecast) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: forecast.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = forecast[index];

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
              )
            ],
          ),
          child: Row(
            children: [
              Lottie.asset(
                getWeatherAsset(item.condition),
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatDate(item.dateTime),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.temperature.round()} °C',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
