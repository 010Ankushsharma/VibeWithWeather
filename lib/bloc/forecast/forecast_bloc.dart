import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vibewithweather/data/models/forecast_model.dart';

import '../../data/services/weather_service.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final WeatherService weatherService;

  ForecastBloc(this.weatherService) : super(ForecastInitial()) {
    on<FetchForecast>(_onFetchForecast);
  }

  Future<void> _onFetchForecast(
      FetchForecast event,
      Emitter<ForecastState> emit,
      ) async {
    emit(ForecastLoading());

    try {
      final forecast =
      await weatherService.getForecast(event.cityName);
      emit(ForecastLoaded(forecast));
    } catch (e) {
      emit(ForecastError('Cannot fetch forecast'));
    }
  }
}