import 'package:flight_search_app/core/constants/api_constants.dart';
import 'package:flight_search_app/features/flight_search/presentation/views/flight_search_page.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late AnimationController _backgroundController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int currentPage = 0;

  final List<OnboardingItem> items = [
    OnboardingItem(
      title: "Search Flights Instantly",
      description: "Find the best flight deals in seconds",
      image: "assets/images/1.png",
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.gradient1, AppColors.gradient3],
      ),
    ),
    OnboardingItem(
      title: "Compare Prices Easily",
      description:
          "Find the best deals on flights from multiple airlines in one place.",
      image: "assets/images/2.png",
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.gradient2, AppColors.gradient4],
      ),
    ),
    OnboardingItem(
      title: "Book with Confidence",
      description:
          "Secure your travel plans with our reliable booking process.",
      image: "assets/images/3.png",
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.gradient5, AppColors.gradient6],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });

    _animationController.reset();
    _animationController.forward();
  }

  void _nextPage() {
    if (currentPage < items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => const FlightSearchPage(),
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                  gradient: items[currentPage].gradient,
                ),
              );
            },
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Skip Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const SizedBox(width: 60),
                      // TextButton(
                      //   onPressed: _navigateToHome,
                      //   child: const Text(
                      //     'Skip',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                // Page Content
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print(items[currentPage].title);
                                  },
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.4,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      // shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: AssetImage(item.image),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                          currentPage == index &&
                                                  items.length == 2
                                              ? BorderRadius.only(
                                                topRight: Radius.circular(40),
                                                // topLeft: Radius.circular(40),
                                                bottomLeft: Radius.circular(40),
                                                bottomRight: Radius.circular(
                                                  40,
                                                ),
                                              )
                                              : currentPage == index &&
                                                  items.length == 3
                                              ? BorderRadius.only(
                                                topRight: Radius.circular(40),
                                                topLeft: Radius.circular(40),
                                                // bottomLeft: Radius.circular(30),
                                                bottomRight: Radius.circular(
                                                  40,
                                                ),
                                              )
                                              : BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                // topRight: Radius.circular(2),
                                                bottomLeft: Radius.circular(30),
                                                bottomRight: Radius.circular(
                                                  30,
                                                ),
                                              ),
                                    ),
                                  ),
                                ),

                                // TweenAnimationBuilder<double>(
                                //   tween: Tween(begin: 0.0, end: 1.0),
                                //   duration: const Duration(milliseconds: 800),
                                //   builder: (context, value, child) {
                                //     return Transform.scale(
                                //       scale: value,
                                //       child: Container(
                                //         width: 200,
                                //         height: 200,
                                //         decoration: BoxDecoration(
                                //           color: Colors.red,
                                //           shape: BoxShape.circle,
                                //         ),
                                //         child: Center(
                                //           child: Image.asset(
                                //             item.image,
                                //             // style: const TextStyle(
                                //             //   fontSize: 60,
                                //             // ),
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                                const SizedBox(height: 20),

                                // Title
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),

                                // Description
                                Text(
                                  item.description,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.9),
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Section
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Page Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          items.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentPage == index ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color:
                                  currentPage == index
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),

                      // Next/Get Started Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor:
                                items[currentPage].gradient.colors.first,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 8,
                            shadowColor: Colors.black.withOpacity(0.3),
                          ),
                          child: Text(
                            currentPage == items.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String image;
  final LinearGradient gradient;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
    required this.gradient,
  });
}
