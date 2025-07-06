import 'package:flight_search_app/core/injector/service_container.dart';
import 'package:flight_search_app/features/flight_search/presentation/providers/favorite_provider.dart';
import 'package:flight_search_app/features/flight_search/presentation/providers/search_provider.dart';
import 'package:flight_search_app/features/onboarding/presentation/onboarding_page.dart';
import 'package:flight_search_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await setUpServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return serviceLocator<FlightSearchProvider>();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return serviceLocator<FavoritesProvider>();
          },
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
