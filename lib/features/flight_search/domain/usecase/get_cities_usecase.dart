import 'package:dartz/dartz.dart';
import 'package:flight_search_app/core/errors/failures.dart';
import 'package:flight_search_app/features/flight_search/domain/enities/city.dart';
import 'package:flight_search_app/features/flight_search/domain/repositories/flight_repo.dart';

class GetCitiesUseCase {
  final FlightRepository repository;

  GetCitiesUseCase(this.repository);

  Future<Either<Failure, List<City>>> call(String query) async {
    return await repository.getCities(query);
  }
}
