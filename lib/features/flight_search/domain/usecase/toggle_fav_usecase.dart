import 'package:dartz/dartz.dart';
import 'package:flight_search_app/core/errors/failures.dart';
import 'package:flight_search_app/features/flight_search/domain/repositories/flight_repo.dart';

class ToggleFavoriteUseCase {
  final FlightRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call(String flightId) async {
    return await repository.toggleFavorite(flightId);
  }
}
