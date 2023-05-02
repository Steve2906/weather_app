import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/database/db_provider.dart';

import '../database/locations.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool _isLoading = false;
  LatLng markerPosition = const LatLng(55.76611647103025, 37.63252638691048);
  LatLng updateMarker = const LatLng(0, 0);
  late Marker _positionMarker;
  final Set<Marker> _markers = HashSet<Marker>();

  void _onMapCreated(GoogleMapController controller) {
    _isLoading = true;
    var location = getCurrentLocation();
    setState(() {
      location.then(
              (loc) => markerPosition = LatLng(loc.latitude, loc.longitude));
      _isLoading = false;
    });
  }

  void _updatePlaceMark(LatLng latLng) {
    _reInitMarker(latLng);
    updateMarker = latLng;
  }

  void _reInitMarker(LatLng latLng) {
    _positionMarker = Marker(
      markerId: const MarkerId("Marker"),
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
    return position;
  }

  Future<Locations?> getLocation(LatLng latLng) async {
    List<Placemark> placemark =
    await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemark.isNotEmpty) {
      return Locations(place: placemark[0].locality!, lat: latLng.latitude, lng: latLng.longitude);
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
    return const Center(
      child: CircularProgressIndicator(), // виджет прогресса
    );
  }

  void _savePlace() {
    var savePlace = getLocation(markerPosition);
    savePlace.then((newPlace) {
     insertLocations(locations: newPlace!);
    });
    Navigator.pop(context);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new location"),
        leading: IconButton(icon: const Icon(Icons.navigate_before), onPressed: () { Navigator.pop(context); },),
        actions: <Widget>[
          Visibility(visible: updateMarker.longitude != 0 && updateMarker.latitude !=0, child: IconButton(
            icon: const Icon(Icons.done),
            tooltip: 'Save',
            onPressed: _savePlace,
          ))
        ],
      ),
      body: _pageToDisplay,
    );
  }
}
