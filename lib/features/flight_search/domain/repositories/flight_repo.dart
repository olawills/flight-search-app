import 'package:dartz/dartz.dart';
import 'package:flight_search_app/core/errors/failures.dart';
import 'package:flight_search_app/features/flight_search/domain/enities/city.dart';
import 'package:flight_search_app/features/flight_search/domain/enities/flight.dart';

abstract class FlightRepository {
  Future<Either<Failure, List<FlightEntity>>> searchFlights({
    required String from,
    required String to,
    required DateTime date,
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, List<City>>> getCities(String query);

  Future<Either<Failure, List<FlightEntity>>> getFavoriteFlights();

  Future<Either<Failure, void>> toggleFavorite(String flightId);
}
