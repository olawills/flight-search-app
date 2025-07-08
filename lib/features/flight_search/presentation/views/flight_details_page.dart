import 'package:flight_search_app/features/flight_search/presentation/model/flight.dart';
import 'package:flutter/material.dart';

class FlightDetailsPage extends StatelessWidget {
  final FlightModel flight; // Add this parameter

  const FlightDetailsPage({
    super.key,
    required this.flight, // Make it required
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Flight Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Airline Information - Use dynamic data
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _getAirlineColor(flight.airline),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.flight,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          flight.airline, // Use dynamic airline name
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Flight Number: ${_getFlightNumber(flight.airline)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Aircraft Type
              _buildInfoSection(
                icon: Icons.flight,
                title: 'Aircraft Type',
                subtitle: _getAircraftType(flight.airline),
              ),

              const SizedBox(height: 30),

              // Flight Information Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Flight Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 20),

              // Seat Class - Use dynamic data
              _buildInfoSection(
                icon: Icons.airline_seat_recline_normal,
                title: 'Seat Class',
                subtitle: flight.cabinClass,
              ),

              // Total Duration - Use dynamic data
              _buildInfoSection(
                icon: Icons.schedule,
                title: 'Total Duration',
                subtitle: flight.duration,
              ),

              // Layovers and Stops - Use dynamic data
              _buildInfoSection(
                icon: Icons.location_on_outlined,
                title: 'Layovers and Stops',
                subtitle: flight.stops,
              ),

              // Route Map
              Center(child: Image.asset('assets/images/map.png')),

              const SizedBox(height: 30),

              // Baggage Information Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Baggage Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 20),

              // Checked Baggage
              _buildInfoSection(
                icon: Icons.luggage,
                title: 'Checked Baggage',
                subtitle: '1 checked bag',
              ),

              // Carry-on Baggage
              _buildInfoSection(
                icon: Icons.work_outline,
                title: 'Carry-on Baggage',
                subtitle: '1 carry-on',
              ),

              const SizedBox(height: 30),

              // Policies Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Policies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 20),

              // Cancellation Policy
              _buildPolicySection(
                icon: Icons.description_outlined,
                title: 'Cancellation Policy',
              ),

              // Refund Policy
              _buildPolicySection(
                icon: Icons.description_outlined,
                title: 'Refund Policy',
              ),

              const SizedBox(height: 30),

              // Amenities Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Amenities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 20),

              // In-flight Entertainment
              _buildAmenitySection(
                icon: Icons.tv,
                title: 'In-flight Entertainment',
              ),

              // Wi-Fi
              _buildAmenitySection(icon: Icons.wifi, title: 'Wi-Fi'),

              // Meals
              _buildAmenitySection(icon: Icons.restaurant, title: 'Meals'),

              const SizedBox(height: 30),

              // Continue to Book Button with dynamic price
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Booking ${flight.airline} flight for \$${flight.price}',
                          ),
                        ),
                      );
                      Navigator.pop(context);
                      Navigator.pop(context, true); // Close the details page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90E2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue to Book - \$${flight.price}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods to get airline-specific data
  Color _getAirlineColor(String airline) {
    switch (airline) {
      case 'Alaska Airlines':
        return const Color(0xFF2E5B6B);
      case 'American Airlines':
        return const Color(0xFFCC0000);
      case 'Delta Airlines':
        return const Color(0xFF003366);
      case 'United Airlines':
        return const Color(0xFF1E3A8A);
      default:
        return const Color(0xFF1E3A8A);
    }
  }

  String _getFlightNumber(String airline) {
    switch (airline) {
      case 'Alaska Airlines':
        return 'AS456';
      case 'American Airlines':
        return 'AA789';
      case 'Delta Airlines':
        return 'DL101';
      case 'United Airlines':
        return 'UA123';
      default:
        return 'XX000';
    }
  }

  String _getAircraftType(String airline) {
    switch (airline) {
      case 'Alaska Airlines':
        return 'Boeing 737-800';
      case 'American Airlines':
        return 'Airbus A321';
      case 'Delta Airlines':
        return 'Boeing 757';
      case 'United Airlines':
        return 'Boeing 737';
      default:
        return 'Boeing 737';
    }
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.grey[600], size: 20),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPolicySection({required IconData icon, required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.grey[600], size: 20),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitySection({required IconData icon, required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.grey[600], size: 20),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
