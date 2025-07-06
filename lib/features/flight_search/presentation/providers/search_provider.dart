import 'package:flight_search_app/features/flight_search/domain/enities/city.dart';
import 'package:flight_search_app/features/flight_search/domain/enities/flight.dart';
import 'package:flight_search_app/features/flight_search/domain/usecase/get_cities_usecase.dart';
import 'package:flight_search_app/features/flight_search/domain/usecase/search_flight_usecase.dart';
import 'package:flight_search_app/features/flight_search/domain/usecase/toggle_fav_usecase.dart';
import 'package:flutter/material.dart';

class FlightSearchProvider extends ChangeNotifier {
  final SearchFlightsUseCase _searchFlightsUseCase;
  final GetCitiesUseCase _getCitiesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  FlightSearchProvider({
    required SearchFlightsUseCase searchFlightsUseCase,
    required GetCitiesUseCase getCitiesUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
  }) : _searchFlightsUseCase = searchFlightsUseCase,
       _getCitiesUseCase = getCitiesUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase;

  List<FlightEntity> _flights = [];
  List<City> _cities = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasMore = true;
  int _currentPage = 1;

  // Getters
  List<FlightEntity> get flights => _flights;
  List<City> get cities => _cities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;

  // Search flights
  Future<void> searchFlights({
    required String from,
    required String to,
    required DateTime date,
    bool isLoadMore = false,
  }) async {
    if (!isLoadMore) {
      _isLoading = true;
      _errorMessage = null;
      _currentPage = 1;
      notifyListeners();
    }

    final result = await _searchFlightsUseCase(
      SearchFlightsParams(from: from, to: to, date: date, page: _currentPage),
    );

    result.fold(
      (failure) {
        _isLoading = false;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (newFlights) {
        _flights = isLoadMore ? [..._flights, ...newFlights] : newFlights;
        _isLoading = false;
        _errorMessage = null;
        _hasMore = newFlights.isNotEmpty;
        _currentPage++;
        notifyListeners();
      },
    );
  }

  // Get cities for autocomplete
  Future<void> getCities(String query) async {
    if (query.isEmpty) {
      _cities = [];
      notifyListeners();
      return;
    }

    final result = await _getCitiesUseCase(query);
    result.fold(
      (failure) {
        _cities = [];
        notifyListeners();
      },
      (cities) {
        _cities = cities;
        notifyListeners();
      },
    );
  }

  // Toggle favorite
  Future<void> toggleFavorite(String flightId) async {
    final result = await _toggleFavoriteUseCase(flightId);
    result.fold(
      (failure) {
        // Handle error if needed
      },
      (_) {
        // Update local flight list
        _flights =
            _flights.map((flight) {
              if (flight.id == flightId) {
                return flight.copyWith(isFavorite: !flight.isFavorite);
              }
              return flight;
            }).toList();
        notifyListeners();
      },
    );
  }

  // Clear results
  void clearResults() {
    _flights = [];
    _cities = [];
    _isLoading = false;
    _errorMessage = null;
    _hasMore = true;
    _currentPage = 1;
    notifyListeners();
  }
}
