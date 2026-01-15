import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibewithweather/data/models/weather_model.dart';
import 'package:vibewithweather/data/services/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherInitial()) {
    on<FetchWeatherEvent>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
      FetchWeatherEvent event,
      Emitter<WeatherState> emit,
      ) async {
    emit(WeatherLoading());

    try {
      final city = await weatherService.getCurrentCity();
      final weather = await weatherService.getWeather(city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Cannot Fetch weather'));
    }
  }
}
