import 'package:diabe_trek/screens/meal_plan/wound_history.dart';
import 'package:flutter/material.dart';
import 'package:diabe_trek/screens/meal_plan/camera_screen.dart';
import 'package:diabe_trek/screens/meal_plan/home_screen.dart';

class ScreenRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      // case "/camera":
      //   return PageRouteBuilder(
      //     pageBuilder: (_, __, ___) => CameraScreen(),
      //     transitionDuration: const Duration(milliseconds: 300),
      //     settings: settings,
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
      //       position: Tween<Offset>(
      //         begin: const Offset(1.0, 0.0),
      //         end: Offset.zero,
      //       ).animate(animation),
      //       child: child,
      //     ),
      //   );
      default:
        return null;
    }
  }
}

Route createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const WoundHistory(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
