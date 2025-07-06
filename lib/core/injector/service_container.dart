import 'package:dio/dio.dart';
import 'package:flight_search_app/core/network/dio_client.dart';
import 'package:flight_search_app/features/flight_search/data/datasource/remote/flight_remote_datascource.dart';
import 'package:flight_search_app/features/flight_search/data/repositories/flight_repo_impl.dart';
import 'package:flight_search_app/features/flight_search/domain/repositories/flight_repo.dart';
import 'package:flight_search_app/features/flight_search/domain/usecase/get_cities_usecase.dart';
import 'package:flight_search_app/features/flight_search/domain/usecase/search_flight_usecase.dart';
import 'package:flight_search_app/features/flight_search/domain/usecase/toggle_fav_usecase.dart';
import 'package:flight_search_app/features/flight_search/presentation/providers/favorite_provider.dart';
import 'package:flight_search_app/features/flight_search/presentation/providers/search_provider.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setUpServiceLocator() async {
  serviceLocator.registerFactory<FlightSearchProvider>(
    () => FlightSearchProvider(
      searchFlightsUseCase: serviceLocator<SearchFlightsUseCase>(),
      getCitiesUseCase: serviceLocator<GetCitiesUseCase>(),
      toggleFavoriteUseCase: serviceLocator<ToggleFavoriteUseCase>(),
    ),
  );

  serviceLocator.registerFactory<FavoritesProvider>(() => FavoritesProvider());

  serviceLocator.registerLazySingleton<FlightRepository>(
    () => FlightRepositoryImpl(
      remoteDataSource: serviceLocator<FlightRemoteDataSource>(),
      // localDataSource: serviceLocator<FlightLocalDataSource>(),
    ),
  );
  serviceLocator.registerLazySingleton<FlightRemoteDataSource>(
    () => FlightRemoteDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<DioClient>(() => DioClient());
  // serviceLocator.registerLazySingleton<FlightLocalDataSource>(
  //   () => FlightLocalDataSourceImpl(serviceLocator<Box<Map<String, dynamic>>>()),
  // );

  serviceLocator.registerLazySingleton<GetCitiesUseCase>(
    () => GetCitiesUseCase(serviceLocator<FlightRepository>()),
  );
  serviceLocator.registerLazySingleton<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(serviceLocator<FlightRepository>()),
  );
  serviceLocator.registerLazySingleton<SearchFlightsUseCase>(
    () => SearchFlightsUseCase(serviceLocator<FlightRepository>()),
  );

  serviceLocator.registerLazySingleton<Dio>(() => Dio());
}
