part of 'forecast_bloc.dart';



@immutable
sealed class ForecastEvent extends Equatable {
  const ForecastEvent();

  @override
  List<Object?> get props=>[];
}

class FetchForecast extends ForecastEvent {
  final String cityName;

  FetchForecast(this.cityName);
}