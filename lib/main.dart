import 'package:apiintegration/Services/AvengerServices/MockAvengerService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'App.dart';
import 'BO/AvengerBO/AvengerBO.mapper.g.dart';
import 'Services/AvengerServices/AvengerService.dart';
import 'Services/AvengerServices/IAvengerService.dart';
import 'main.reflectable.dart';

void main() {
  initializeReflectable();
  initializeJsonMapper();
  GetIt.instance.registerSingleton<IAvengerService>(AvengerService());
  runApp(const App());
}
