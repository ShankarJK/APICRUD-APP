// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'Helpers/AppNavigations/NavigationConfig.dart';
import 'Helpers/AppNavigations/NavigationHelpers.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      
      // Assign the value of constructor AppRoute and pass the homescreencofig as initial page
      onGenerateRoute: AppRoute(
        initialPage: Pages.homeScreenConfig,
        initialPageData: "",
      ).onGenerateRoute,
    );
  }
}
