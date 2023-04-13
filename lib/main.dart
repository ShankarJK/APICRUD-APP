import 'package:apiintegration/Services/AvengerServices/MockAvengerService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'App.dart';
import 'BO/AvengerBO/AvengerBO.mapper.g.dart';
import 'Services/AvengerServices/AvengerService.dart';
import 'Services/AvengerServices/IAvengerService.dart';
import 'main.reflectable.dart';

/* Declare a main() */
void main() {

  // Invoke the  initializeReflectable()
  initializeReflectable();

  // Invoke the  initializeJsonMapper() 
  initializeJsonMapper();

  //  Create a instance of IAvengerService using GetIt
  GetIt.instance.registerSingleton<IAvengerService>(AvengerService());

  // Invoke the runApp() and pass the MyApp as parameter.
  runApp(const App());
}
