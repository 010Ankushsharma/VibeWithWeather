import '../data/models/forecast_model.dart';


List<ForecastModel> filterDailyForecast(List<ForecastModel> list) {
  final Map<String, ForecastModel> daily = {};

  for (final item in list) {
    final key =
        '${item.dateTime.year}-${item.dateTime.month}-${item.dateTime.day}';

    daily.putIfAbsent(key, () => item);
  }

  return daily.values.take(5).toList();
}
