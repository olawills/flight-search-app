import 'package:flutter/widgets.dart';

class FlightModel {
  final String airline;
  final Color logo;
  final int price;
  final String cabinClass;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String stops;
  final String departureCode;
  final String arrivalCode;
  final bool isNonStop;

  FlightModel({
    required this.airline,
    required this.logo,
    required this.price,
    required this.cabinClass,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.stops,
    required this.departureCode,
    required this.arrivalCode,
    required this.isNonStop,
  });
}
