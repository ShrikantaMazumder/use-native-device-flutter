import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:use_native_device_flutter/helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _imagePreviewUrl;
  Location _location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionStatus;
  LocationData _locationData;

  Future<void> _getCurrentUserLocation() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
      _locationData = await _location.getLocation();
      final selectLocationImage = LocationHelper.generateLocationPreviewImage(
          latitude: _locationData.latitude, longitude: _locationData.longitude);
      setState(() {
        _imagePreviewUrl = selectLocationImage;
      });
      print(_locationData.latitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _imagePreviewUrl == null
              ? Center(
                  child: Text("No location choosen"),
                )
              : Image.network(
                  _imagePreviewUrl,
                  fit: BoxFit.fill,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              onPressed: () => _getCurrentUserLocation(),
              icon: Icon(Icons.location_off,
                  color: Theme.of(context).primaryColor),
              label: Text(
                "Current location",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map, color: Theme.of(context).primaryColor),
              label: Text(
                "Select on map",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            )
          ],
        )
      ],
    );
  }
}
