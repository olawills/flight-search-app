import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String code;
  final String name;
  final String country;
  final String? airportCode;

  const City({
    required this.code,
    required this.name,
    required this.country,
    this.airportCode,
  });

  @override
  List<Object?> get props => [code, name, country, airportCode];

  @override
  String toString() => '$name, $country ($code)';
}
