import 'package:dartz/dartz.dart';
import 'package:flight_search_app/core/errors/failures.dart';
import 'package:flight_search_app/features/flight_search/data/datasource/remote/flight_remote_datascource.dart';
import 'package:flight_search_app/features/flight_search/domain/enities/city.dart';
import 'package:flight_search_app/features/flight_search/domain/enities/flight.dart';
import 'package:flight_search_app/features/flight_search/domain/repositories/flight_repo.dart';

class FlightRepositoryImpl implements FlightRepository {
  final FlightRemoteDataSource remoteDataSource;
  // final FlightLocalDataSource localDataSource;

  FlightRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<FlightEntity>>> searchFlights({
    required String from,
    required String to,
    required DateTime date,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final flights = await remoteDataSource.searchFlights(
        from: from,
        to: to,
        date: date,
        page: page,
        limit: limit,
      );
      return Right(flights);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<City>>> getCities(String query) async {
    try {
      final cities = await remoteDataSource.getCities(query);
      return Right(cities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FlightEntity>>> getFavoriteFlights() async {
    try {
      // final flights = await localDataSource.getFavoriteFlights();
      return Right([]);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String flightId) async {
    try {
      // await localDataSource.toggleFavorite(flightId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
