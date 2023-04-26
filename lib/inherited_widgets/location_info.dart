import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

class LocationInfo extends InheritedWidget {
  final Position position;


  LocationInfo(this.position, Widget child):super(child: child);
  static LocationInfo? of (BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LocationInfo>();

  @override
  bool updateShouldNotify(Position)  {
    var oldLocationTime = position.timestamp?.millisecondsSinceEpoch?? 0;
    var newLocationTime = position.timestamp?.millisecondsSinceEpoch?? 0;

    if(oldLocationTime == 0 && newLocationTime == 0){
      return true;
    }
    return oldLocationTime<newLocationTime;
  }

}

class LocationInheritedWidget extends StatefulWidget {
  static LocationInfo of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LocationInfo>() as LocationInfo;

  const LocationInheritedWidget({required this.child});

  final Widget child;

  @override
  _LocationInheritedState createState() => _LocationInheritedState();
}

class _LocationInheritedState extends State<LocationInheritedWidget> {
  late Position position;

  void _loadData() {
    var locationFuture = getLocation();
locationFuture.then((newPosition) {
  onPositionChange(newPosition);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void onPositionChange(Position newPosition) {
    setState(() {
      position = newPosition;
    });
  }

  Widget build(BuildContext context) {
    return LocationInfo(position, widget.child);
  }

  Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    return position;
  }

}