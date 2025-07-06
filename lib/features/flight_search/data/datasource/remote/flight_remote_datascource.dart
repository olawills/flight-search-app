import 'package:flight_search_app/core/constants/api_constants.dart';
import 'package:flight_search_app/core/injector/service_container.dart';
import 'package:flight_search_app/core/network/dio_client.dart';
import 'package:flight_search_app/features/flight_search/data/model/city.dart';
import 'package:flight_search_app/features/flight_search/data/model/flight.dart';

abstract class FlightRemoteDataSource {
  Future<List<FlightModel>> searchFlights({
    required String from,
    required String to,
    required DateTime date,
    int page = 1,
    int limit = 20,
  });

  Future<List<CityModel>> getCities(String query);
}

class FlightRemoteDataSourceImpl implements FlightRemoteDataSource {
  final DioClient dioClient = serviceLocator<DioClient>();

  @override
  Future<List<FlightModel>> searchFlights({
    required String from,
    required String to,
    required DateTime date,
    int page = 1,
    int limit = 20,
  }) async {
    // For demo purposes, return mock data
    if (AppConstants.useMockData) {
      return _getMockFlights(from, to, date);
    }

    final response = await dioClient.dio.get(
      '/flights',
      queryParameters: {
        'access_key': AppConstants.apiKey,
        'dep_iata': from,
        'arr_iata': to,
        'flight_date': date.toIso8601String().split('T')[0],
        'limit': limit,
        'offset': (page - 1) * limit,
      },
    );

    final List<dynamic> data = response.data['data'];
    return data.map((json) => FlightModel.fromJson(json)).toList();
  }

  @override
  Future<List<CityModel>> getCities(String query) async {
    // Return mock cities for demo
    return _getMockCities()
        .where(
          (city) =>
              city.name.toLowerCase().contains(query.toLowerCase()) ||
              city.code.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  List<FlightModel> _getMockFlights(String from, String to, DateTime date) {
    final now = DateTime.now();
    final baseDate = DateTime(date.year, date.month, date.day);

    return [
      FlightModel(
        id: '1',
        flightNumber: 'AA123',
        airline: 'American Airlines',
        aircraft: 'Boeing 737',
        departureCity: from,
        arrivalCity: to,
        departureAirport: '$from Airport',
        arrivalAirport: '$to Airport',
        departureTime: baseDate.add(const Duration(hours: 8)),
        arrivalTime: baseDate.add(const Duration(hours: 11, minutes: 30)),
        duration: const Duration(hours: 3, minutes: 30),
        price: 299.99,
        currency: 'USD',
        stops: 0,
        stopCities: [],
      ),
      FlightModel(
        id: '2',
        flightNumber: 'DL456',
        airline: 'Delta Airlines',
        aircraft: 'Airbus A320',
        departureCity: from,
        arrivalCity: to,
        departureAirport: '$from Airport',
        arrivalAirport: '$to Airport',
        departureTime: baseDate.add(const Duration(hours: 14)),
        arrivalTime: baseDate.add(const Duration(hours: 18, minutes: 45)),
        duration: const Duration(hours: 4, minutes: 45),
        price: 399.99,
        currency: 'USD',
        stops: 1,
        stopCities: ['Atlanta'],
      ),
      FlightModel(
        id: '3',
        flightNumber: 'UA789',
        airline: 'United Airlines',
        aircraft: 'Boeing 777',
        departureCity: from,
        arrivalCity: to,
        departureAirport: '$from Airport',
        arrivalAirport: '$to Airport',
        departureTime: baseDate.add(const Duration(hours: 20)),
        arrivalTime: baseDate.add(
          const Duration(days: 1, hours: 1, minutes: 15),
        ),
        duration: const Duration(hours: 5, minutes: 15),
        price: 459.99,
        currency: 'USD',
        stops: 0,
        stopCities: [],
      ),
    ];
  }

  List<CityModel> _getMockCities() {
    return [
      const CityModel(
        code: 'NYC',
        name: 'New York',
        country: 'USA',
        airportCode: 'JFK',
      ),
      const CityModel(
        code: 'LAX',
        name: 'Los Angeles',
        country: 'USA',
        airportCode: 'LAX',
      ),
      const CityModel(
        code: 'CHI',
        name: 'Chicago',
        country: 'USA',
        airportCode: 'ORD',
      ),
      const CityModel(
        code: 'MIA',
        name: 'Miami',
        country: 'USA',
        airportCode: 'MIA',
      ),
      const CityModel(
        code: 'LAS',
        name: 'Las Vegas',
        country: 'USA',
        airportCode: 'LAS',
      ),
      const CityModel(
        code: 'LON',
        name: 'London',
        country: 'UK',
        airportCode: 'LHR',
      ),
      const CityModel(
        code: 'PAR',
        name: 'Paris',
        country: 'France',
        airportCode: 'CDG',
      ),
      const CityModel(
        code: 'TOK',
        name: 'Tokyo',
        country: 'Japan',
        airportCode: 'NRT',
      ),
    ];
  }
}
