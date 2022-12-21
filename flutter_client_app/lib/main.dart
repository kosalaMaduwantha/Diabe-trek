import 'package:diabe_trek/screens/HomePage.dart';
import 'package:diabe_trek/screens/PHYACT/create_new_routine_p1(routines_created)(phy).dart';
import 'package:diabe_trek/utils/app_styles.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diab-Trek Demo',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: const HomePage(),
    );
  }
}