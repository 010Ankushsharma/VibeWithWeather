
class ForecastModel {
  final DateTime dateTime;
  final double temperature;
  final String condition;

  ForecastModel({
    required this.dateTime,
    required this.temperature,
    required this.condition
});
  factory ForecastModel.formJson(Map<String,dynamic> json){
  return ForecastModel(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature:  json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
  );
  }
}