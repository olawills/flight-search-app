import 'package:flight_search_app/features/flight_search/domain/enities/city.dart';

class CityModel extends City {
  const CityModel({
    required super.code,
    required super.name,
    required super.country,
    super.airportCode,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      airportCode: json['airport_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'country': country,
      'airport_code': airportCode,
    };
  }
}
