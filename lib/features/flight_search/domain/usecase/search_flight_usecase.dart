import 'package:dartz/dartz.dart';
import 'package:flight_search_app/core/errors/failures.dart';
import 'package:flight_search_app/features/flight_search/domain/enities/flight.dart';
import 'package:flight_search_app/features/flight_search/domain/repositories/flight_repo.dart';

class SearchFlightsUseCase {
  final FlightRepository repository;

  SearchFlightsUseCase(this.repository);

  Future<Either<Failure, List<FlightEntity>>> call(
    SearchFlightsParams params,
  ) async {
    return await repository.searchFlights(
      from: params.from,
      to: params.to,
      date: params.date,
      page: params.page,
      limit: params.limit,
    );
  }
}

class SearchFlightsParams {
  final String from;
  final String to;
  final DateTime date;
  final int page;
  final int limit;

  SearchFlightsParams({
    required this.from,
    required this.to,
    required this.date,
    this.page = 1,
    this.limit = 20,
  });
}
