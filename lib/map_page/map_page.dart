import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../places_page/places_page.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Locations markerLocation = Locations(55.7532, 37.6206, "Moscow");
  bool _isLoading = false;
  LatLng markerPosition = LatLng(58.7532, 37.6206);
  LatLng updateMarker = LatLng(0, 0);
  late Marker _positionMarker;
  Set<Marker> _markers = HashSet<Marker>();

  void _onMapCreated(GoogleMapController controller) {
    _isLoading = true;
    print(_isLoading);
    var location = getCurrentLocation();
    setState(() {
      location.then(
              (loc) => markerPosition = LatLng(loc.latitude, loc.longitude));
      print(markerPosition);
      _isLoading = false;
    });
  }

  void _updatePlaceMark(LatLng latLng) {
    _reInitMarker(latLng);
    updateMarker = latLng;
  }

  void _reInitMarker(LatLng latLng) {
    _positionMarker = Marker(
      markerId: MarkerId("Marker"),
      position: latLng,
      draggable: true,
      onDragEnd: (latLng) {
        _updatePlaceMark(latLng);
      },
    );
    _markers.clear();
    _markers.add(_positionMarker);
    setState(() {

    });
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
    return position;
  }

  Future<Locations?> getLocation(LatLng latLng) async {
    Locations markerLocation = Locations(55.7532, 37.6206, "Moscow");
    markerLocation.lat = latLng.latitude;
    markerLocation.lng = latLng.longitude;
    List<Placemark> placemark =
    await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    markerLocation.place = placemark[0].locality!;
    if (placemark.isNotEmpty) {
      return markerLocation;
    } else {
      return null;
    }
  }

  Widget get _contentView {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      mapType: MapType.normal,
      markers: _markers,
      initialCameraPosition: CameraPosition(
        target: markerPosition,
        zoom: 11.0,
      ),
      onTap: (latLng) => _updatePlaceMark(latLng),
    );
  }

  Widget get _pageToDisplay {
    if (_isLoading) {
      return _loadingView;
    } else {
      return _contentView;
    }
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(), // виджет прогресса
    );
  }

  void _savePlace() {
    var savePlace = getLocation(markerPosition);
    savePlace.then((newPlace) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new location"),
        leading: IconButton(icon: Icon(Icons.navigate_before), onPressed: () { Navigator.pop(context); },),
        actions: <Widget>[
          Visibility(child: new IconButton(
            icon: new Icon(Icons.done),
            tooltip: 'Save',
            onPressed: _savePlace,
          ), visible: updateMarker.longitude != 0 && updateMarker.latitude !=0)
        ],
      ),
      body: _pageToDisplay,
    );
  }
}
