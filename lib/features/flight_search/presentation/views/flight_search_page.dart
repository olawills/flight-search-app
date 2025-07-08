import 'package:flight_search_app/core/constants/api_constants.dart';
import 'package:flight_search_app/core/utils/show_or_not.dart';
import 'package:flight_search_app/features/flight_search/presentation/views/flight_result_page.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FlightSearchPage extends StatefulWidget {
  const FlightSearchPage({super.key});

  @override
  State<FlightSearchPage> createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _searchFlights() {
    if (_formKey.currentState?.validate() ?? false) {
      // provider.searchFlights(
      //   from: _fromCity?.code ?? '',
      //   to: _toCity?.code ?? '',
      //   date: _selectedDate!,
      // );
    }
  }

  String selectedTripType = 'One way';
  bool directFlightsOnly = false;
  bool includeNearbyAirports = false;
  String selectedTravelClass = 'Economy';
  int passengers = 1;
  DateTime? selectedDate;
  String fromCity = '';
  String toCity = '';

  final List<String> tripTypes = ['One way', 'Round trip', 'Multi-City'];
  final List<String> travelClasses = [
    'Economy',
    'Premium Economy',
    'Business',
    'First',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showCityPicker(BuildContext context, bool isFrom) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isFrom ? 'Select Departure City' : 'Select Destination City',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: const Text('Lagos (LOS)'),
                  subtitle: const Text(
                    'Murtala Muhammed International Airport',
                  ),
                  onTap: () {
                    setState(() {
                      if (isFrom) {
                        fromCity = 'Lagos (LOS)';
                      } else {
                        toCity = 'Lagos (LOS)';
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: const Text('Abuja (ABV)'),
                  subtitle: const Text('Nnamdi Azikiwe International Airport'),
                  onTap: () {
                    setState(() {
                      if (isFrom) {
                        fromCity = 'Abuja (ABV)';
                      } else {
                        toCity = 'Abuja (ABV)';
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: const Text('London (LHR)'),
                  subtitle: const Text('Heathrow Airport'),
                  onTap: () {
                    setState(() {
                      if (isFrom) {
                        fromCity = 'London (LHR)';
                      } else {
                        toCity = 'London (LHR)';
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Search Flights'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () => _showCityPicker(context, true),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            fromCity.isEmpty ? 'From' : fromCity,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Icon(Icons.expand_more, color: Colors.grey[600]),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // To Field
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () => _showCityPicker(context, false),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            toCity.isEmpty ? 'To' : toCity,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Icon(Icons.expand_more, color: Colors.grey[600]),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Trip Type Selection
                  Row(
                    children:
                        tripTypes.map((type) {
                          bool isSelected = selectedTripType == type;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTripType = type;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? Colors.blue
                                            : Colors.grey[300]!,
                                  ),
                                ),
                                child: Text(
                                  type,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.blue
                                            : Colors.grey[600],
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Departure Date
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.decoratorColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate == null
                                ? 'Departure Date'
                                : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.decoratorText,
                            ),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Optional Filters
                  Text(
                    'Optional Filters',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Direct Flights Only
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Direct Flights Only',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Switch(
                        value: directFlightsOnly,
                        onChanged: (value) {
                          setState(() {
                            directFlightsOnly = value;
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Include Nearby Airports
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Include Nearby Airports',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Switch(
                        value: includeNearbyAirports,
                        onChanged: (value) {
                          setState(() {
                            includeNearbyAirports = value;
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Travel Class
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Travel Class',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        selectedTravelClass,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      // DropdownButton<String>(
                      //   value: selectedTravelClass,
                      //   underline: Container(),
                      //   items:
                      //       travelClasses.map((String value) {
                      //         return DropdownMenuItem<String>(
                      //           value: value,
                      //           child: Text(value),
                      //         );
                      //       }).toList(),
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       selectedTravelClass = newValue!;
                      //     });
                      //   },
                      // ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Passengers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Passengers',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Spacer(),
                      Text(
                        passengers.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed:
                                passengers > 1
                                    ? () {
                                      setState(() {
                                        passengers--;
                                      });
                                    }
                                    : null,
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            passengers.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed:
                                passengers < 9
                                    ? () {
                                      setState(() {
                                        passengers++;
                                      });
                                    }
                                    : null,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ).showOrHide(false),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Search Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (fromCity.isEmpty || toCity.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all fields'),
                            ),
                          );
                          return;
                        }
                        context.loaderOverlay.show();
                        _searchFlights();
                        context.loaderOverlay.hide();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlightResultPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.butonColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Search Flights',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
