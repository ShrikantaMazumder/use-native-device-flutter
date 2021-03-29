import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_native_device_flutter/provider/places_provider.dart';
import 'package:use_native_device_flutter/routes/rotues.dart';
import 'package:use_native_device_flutter/screens/places_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: Routes().routes,
      ),
    );
  }
}
