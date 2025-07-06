import 'dart:convert';

import 'package:flight_search_app/features/flight_search/data/model/flight.dart';
import 'package:flight_search_app/features/flight_search/domain/enities/flight.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  List<FlightModel> _favorites = [];
  static const String _favoritesKey = 'favorite_flights';

  List<FlightEntity> get favorites => List.unmodifiable(_favorites);

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList(_favoritesKey);

      if (favoritesJson != null) {
        _favorites =
            favoritesJson
                .map((json) => FlightModel.fromJson(jsonDecode(json)))
                .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson =
          _favorites.map((flight) => jsonEncode(flight.toJson())).toList();

      await prefs.setStringList(_favoritesKey, favoritesJson);
    } catch (e) {
      debugPrint('Error saving favorites: $e');
    }
  }

  bool isFavorite(String flightId) {
    return _favorites.any((flight) => flight.id == flightId);
  }

  Future<void> addFavorite(FlightModel flight) async {
    if (!isFavorite(flight.id)) {
      _favorites.add(flight);
      await _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String flightId) async {
    _favorites.removeWhere((flight) => flight.id == flightId);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(FlightModel flight) async {
    if (isFavorite(flight.id)) {
      await removeFavorite(flight.id);
    } else {
      await addFavorite(flight);
    }
  }

  Future<void> clearAllFavorites() async {
    _favorites.clear();
    await _saveFavorites();
    notifyListeners();
  }

  int get favoritesCount => _favorites.length;
}
