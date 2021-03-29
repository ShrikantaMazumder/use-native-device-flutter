import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_native_device_flutter/provider/places_provider.dart';
import 'package:use_native_device_flutter/screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.pushNamed(context, AddPlaceScreen.routeName),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchAndSetData(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<PlacesProvider>(
                    child: Center(
                      child: Text("No places yet. Start adding"),
                    ),
                    builder: (context, places, ch) => places.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: places.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(places.items[index].image),
                              ),
                              title: Text(places.items[index].title),
                            ),
                          ),
                  ),
      ),
    );
  }
}
