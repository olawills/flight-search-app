import 'package:flight_search_app/features/flight_search/domain/enities/flight.dart';

class FlightModel extends FlightEntity {
  const FlightModel({
    required super.id,
    required super.flightNumber,
    required super.airline,
    super.airlineLogo,
    required super.aircraft,
    required super.departureCity,
    required super.arrivalCity,
    required super.departureAirport,
    required super.arrivalAirport,
    required super.departureTime,
    required super.arrivalTime,
    required super.duration,
    required super.price,
    required super.currency,
    required super.stops,
    required super.stopCities,
    super.isFavorite,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json['id'] ?? '',
      flightNumber: json['flight_number'] ?? '',
      airline: json['airline'] ?? '',
      airlineLogo: json['airline_logo'],
      aircraft: json['aircraft'] ?? '',
      departureCity: json['departure_city'] ?? '',
      arrivalCity: json['arrival_city'] ?? '',
      departureAirport: json['departure_airport'] ?? '',
      arrivalAirport: json['arrival_airport'] ?? '',
      departureTime: DateTime.parse(json['departure_time']),
      arrivalTime: DateTime.parse(json['arrival_time']),
      duration: Duration(minutes: json['duration_minutes'] ?? 0),
      price: (json['price'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'USD',
      stops: json['stops'] ?? 0,
      stopCities: List<String>.from(json['stop_cities'] ?? []),
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flight_number': flightNumber,
      'airline': airline,
      'airline_logo': airlineLogo,
      'aircraft': aircraft,
      'departure_city': departureCity,
      'arrival_city': arrivalCity,
      'departure_airport': departureAirport,
      'arrival_airport': arrivalAirport,
      'departure_time': departureTime.toIso8601String(),
      'arrival_time': arrivalTime.toIso8601String(),
      'duration_minutes': duration.inMinutes,
      'price': price,
      'currency': currency,
      'stops': stops,
      'stop_cities': stopCities,
      'is_favorite': isFavorite,
    };
  }
}
