part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState{}

class WeatherLoaded extends WeatherState{
  final WeatherModel weather;

  WeatherLoaded(this.weather);
}

class WeatherError extends WeatherState{
  final String message;

  WeatherError(this.message);
}

