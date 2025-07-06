// import 'package:flight_search_app/features/flight_search/data/model/flight.dart';
// import 'package:hive/hive.dart';

// abstract class FlightLocalDataSource {
//   Future<List<FlightModel>> getFavoriteFlights();
//   Future<void> cacheFavoriteFlights(List<FlightModel> flights);
//   Future<void> toggleFavorite(String flightId);
// }

// class FlightLocalDataSourceImpl implements FlightLocalDataSource {
//   final Box<Map<String, dynamic>> _box;

//   FlightLocalDataSourceImpl(this._box);

//   @override
//   Future<List<FlightModel>> getFavoriteFlights() async {
//     final favoriteIds = _box.get('favorite_flights', defaultValue: {});
//     final flights = <FlightModel>[];

//     for (String id in favoriteIds) {
//       final flightData = _box.get('flight_$id');
//       if (flightData != null) {
//         flights.add(
//           FlightModel.fromJson(Map<String, dynamic>.from(flightData)),
//         );
//       }
//     }

//     return flights;
//   }

//   @override
//   Future<void> cacheFavoriteFlights(List<FlightModel> flights) async {
//     for (final flight in flights) {
//       await _box.put('flight_${flight.id}', flight.toJson());
//     }
//   }

//   @override
//   Future<void> toggleFavorite(String flightId) async {
//     final favoriteIds = List<String>.from(
//       _box.get('favorite_flights', defaultValue: <String>[]),
//     );

//     if (favoriteIds.contains(flightId)) {
//       favoriteIds.remove(flightId);
//       await _box.delete('flight_$flightId');
//     } else {
//       favoriteIds.add(flightId);
//     }

//     await _box.put('favorite_flights', favoriteIds);
//   }
// }
