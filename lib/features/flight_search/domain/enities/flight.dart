import 'package:equatable/equatable.dart';

class FlightEntity extends Equatable {
  final String id;
  final String flightNumber;
  final String airline;
  final String? airlineLogo;
  final String aircraft;
  final String departureCity;
  final String arrivalCity;
  final String departureAirport;
  final String arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final Duration duration;
  final double price;
  final String currency;
  final int stops;
  final List<String> stopCities;
  final bool isFavorite;

  const FlightEntity({
    required this.id,
    required this.flightNumber,
    required this.airline,
    this.airlineLogo,
    required this.aircraft,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.currency,
    required this.stops,
    required this.stopCities,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
    id,
    flightNumber,
    airline,
    airlineLogo,
    aircraft,
    departureCity,
    arrivalCity,
    departureAirport,
    arrivalAirport,
    departureTime,
    arrivalTime,
    duration,
    price,
    currency,
    stops,
    stopCities,
    isFavorite,
  ];

  FlightEntity copyWith({
    String? id,
    String? flightNumber,
    String? airline,
    String? airlineLogo,
    String? aircraft,
    String? departureCity,
    String? arrivalCity,
    String? departureAirport,
    String? arrivalAirport,
    DateTime? departureTime,
    DateTime? arrivalTime,
    Duration? duration,
    double? price,
    String? currency,
    int? stops,
    List<String>? stopCities,
    bool? isFavorite,
  }) {
    return FlightEntity(
      id: id ?? this.id,
      flightNumber: flightNumber ?? this.flightNumber,
      airline: airline ?? this.airline,
      airlineLogo: airlineLogo ?? this.airlineLogo,
      aircraft: aircraft ?? this.aircraft,
      departureCity: departureCity ?? this.departureCity,
      arrivalCity: arrivalCity ?? this.arrivalCity,
      departureAirport: departureAirport ?? this.departureAirport,
      arrivalAirport: arrivalAirport ?? this.arrivalAirport,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      stops: stops ?? this.stops,
      stopCities: stopCities ?? this.stopCities,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
