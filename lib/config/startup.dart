import 'package:episode_plus/config/screen_routes.dart';
import 'package:episode_plus/screens/home_screen.dart';
import 'package:episode_plus/screens/series_form_screen.dart';
import 'package:flutter/material.dart';

class EpisodePlus extends StatelessWidget {
  const EpisodePlus({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Episode Plus',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        ScreenRoutes.homeScreen: (context) => const HomeScreen(),
        ScreenRoutes.seriesFormScreen: (context) => const SeriesFormScreen()
      },
    );
  }
}
