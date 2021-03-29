import 'dart:io';

import 'package:flutter/material.dart';
import 'package:use_native_device_flutter/helpers/db_helper.dart';
import 'package:use_native_device_flutter/models/place.dart';
import 'package:uuid/uuid.dart';

class PlacesProvider with ChangeNotifier {
  final uuid = Uuid();
  List<Place> _items = [];

  get items {
    return [..._items];
  }

  addPlace(String title, File image) {
    final newPlace = Place(
      id: uuid.v4(),
      title: title,
      location: null,
      image: image,
    );
    _items.insert(0, newPlace);
    notifyListeners();
    DBHelper.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
    });
  }

  Future<void> fetchAndSetData() async {
    final data = await DBHelper.getData("user_places");
    _items = data
        .map((item) => Place(
            id: item["id"],
            title: item["title"],
            location: null,
            image: File(item["image"])))
        .toList();
  }
}
