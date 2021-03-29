import 'package:flutter/material.dart';
import 'package:use_native_device_flutter/screens/add_place_screen.dart';

class Routes {
  static const addPlace = AddPlaceScreen.routeName;

  final routes = <String, WidgetBuilder>{
    Routes.addPlace: (ctx) => AddPlaceScreen(),
  };
}
