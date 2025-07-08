import 'package:flight_search_app/core/constants/api_constants.dart';
import 'package:flight_search_app/features/flight_search/presentation/model/flight.dart';
import 'package:flight_search_app/features/flight_search/presentation/views/flight_details_page.dart';
import 'package:flight_search_app/features/flight_search/presentation/widgets/flight_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FlightResultPage extends StatefulWidget {
  const FlightResultPage({super.key});

  @override
  State<FlightResultPage> createState() => _FlightResultPageState();
}

class _FlightResultPageState extends State<FlightResultPage>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  final PageController _pageController = PageController();

  final List<FlightModel> flights = [
    FlightModel(
      airline: 'Alaska Airlines',
      logo: const Color(0xFF2E5B6B),
      price: 320,
      cabinClass: 'Economy',
      departureTime: '1:00 PM',
      arrivalTime: '4:00 PM',
      duration: '6h 0m',
      stops: '1 Stop',
      departureCode: 'JFK',
      arrivalCode: 'LAX',
      isNonStop: false,
    ),
    FlightModel(
      airline: 'American Airlines',
      logo: const Color(0xFF2E5B6B),
      price: 285,
      cabinClass: 'Economy',
      departureTime: '12:30 PM',
      arrivalTime: '3:45 PM',
      duration: '6h 15m',
      stops: 'Non-stop',
      departureCode: 'JFK',
      arrivalCode: 'LAX',
      isNonStop: true,
    ),
    FlightModel(
      airline: 'Delta Airlines',
      logo: const Color(0xFF2E5B6B),
      price: 342,
      cabinClass: 'Economy',
      departureTime: '2:15 PM',
      arrivalTime: '5:30 PM',
      duration: '6h 15m',
      stops: 'Non-stop',
      departureCode: 'JFK',
      arrivalCode: 'LAX',
      isNonStop: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F4F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Flights'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Route Header
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JFK',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'New York',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.decoratorText,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.decoratorColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset('assets/svg/airplane.svg'),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'LAX',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Los Angeles',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.decoratorText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Date and Passengers
            Text(
              'Fri, Jul 12 • 1 Adult',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // Sort & Filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sort & Filter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
                Icon(Icons.tune, color: AppColors.textPrimary, size: 28),
              ],
            ),
            const SizedBox(height: 25),

            // Flight Cards
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.28,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: flights.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => FlightDetailsPage(
                                  flight:
                                      flights[index], // Pass selected flight data
                                ),
                          ),
                        );
                      },
                      child: FlightCard(flight: flights[index]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                flights.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        currentPage == index
                            ? const Color(0xFF4A90E2)
                            : Colors.grey[400],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
