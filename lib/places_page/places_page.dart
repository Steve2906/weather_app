import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/database/db_provider.dart';
import 'package:weather_app/map_page/map_page.dart';
import '../database/locations.dart';
import '../nogps_page/no_gps_page.dart';
import '../weather_page/weather_page.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({Key? key}) : super(key: key);

  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  late List<Locations> allLocations;
  bool _isLoading = true;

  Future<bool?> requestpermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const noGPSPage()));
    }
    if (status.isGranted) {
      return true;
    }
    return true;
  }

  @override
  initState() {
    super.initState();
    loadData();
    requestpermission();
  }

  Future<void> refreshPage() async {
    loadData();
  }

  void loadData() {
    var getAllLoc = getAllLocations();
    getAllLoc.then((value) {
      setState(() {
        allLocations = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Places"),
      ),
      body: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: InkWell(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WeatherForecastPage(nullplace)))
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Current position",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    )),
              ),
            )),
            const Divider(height: 4, thickness: 2)
          ],
        ),
        const Divider(height: 1.4,color: Colors.black),
        Expanded(child: _pageToDisplay),
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MapPage()));
          },
          child: const Icon(Icons.add, color: Colors.white)),
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
      child: CircularProgressIndicator(),
    );
  }

  Widget get _contentView {
    return RefreshIndicator(
        onRefresh: refreshPage,
        child: ListView.builder(
            itemCount: allLocations.length,
            itemBuilder: (context, index) {
              final place = allLocations[index];
              return Dismissible(
                key: Key(place.place),
                onDismissed: (direction) {
                  deleteLocations(locations: allLocations[index]);
                },
                child: ListTile(
                    title: Text(place.place),
                    onTap: () => _onItemTapped(place)),
              );
            }));
  }

  void _onItemTapped(Locations place) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WeatherForecastPage(place)));
  }
}
