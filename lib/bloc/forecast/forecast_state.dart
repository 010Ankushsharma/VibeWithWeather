part of 'forecast_bloc.dart';

@immutable
sealed class ForecastState {}

final class ForecastInitial extends ForecastState {}

final class ForecastLoading extends ForecastState{}

class ForecastLoaded extends ForecastState {
final List<ForecastModel> forecast;

ForecastLoaded(this.forecast);
}

class ForecastError extends ForecastState {
  final String message;

  ForecastError(this.message);
}