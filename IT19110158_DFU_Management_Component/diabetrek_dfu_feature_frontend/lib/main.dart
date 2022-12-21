import 'package:flutter/material.dart';
import 'routes/screen_routes.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DFUApp());
}

class DFUApp extends StatelessWidget {
  const DFUApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DFU Selfcare Feature',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      onGenerateRoute: ScreenRoutes.generateRoute,
    );
  }
}
