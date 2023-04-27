import 'package:flutter/material.dart';
import '../weather_page/weather_page.dart';

class Locations {
  double lat = 55.751244;
  double lng = 37.618423;
  String place = "Loading...";

  Locations(this.lat, this.lng, this.place);
}

class PlacesPage extends StatefulWidget {
  PlacesPage({Key? key}) : super(key: key);

  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  Locations place = Locations(55.7532, 37.6206, "Moscow");
  final _places = [
    Locations(55.7532, 37.6206, "Moscow"),
    Locations(40.7715, -73.9739, "New York"),
    Locations(53.893009, 27.567444, "Minsk"),
  ];
  Locations nullplace = Locations(0.0, 0.0, "nullplace");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Places"),
        ),
        body: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: InkWell(
                onTap: () => {Navigator.push(context,
    MaterialPageRoute(builder: (context) => WeatherForecastPage(nullplace)))},
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Current position",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      )),
                ),
              )),
              const Divider(height: 4, thickness: 2)
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _places.length,
                  itemBuilder: (context, index) {
                    final place = _places[index];
                    return Dismissible(
                        key: Key(place.place),
                        onDismissed: (direction) {
                          setState(() {
                            _places.removeAt(index);
                          });
                        },
                        child: ListTile(
                            title: Text(place.place),
                            onTap: () => _onItemTapped(place)),);
                  })),
        ]));
  }

  void _onItemTapped(Locations place) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WeatherForecastPage(place)));
  }
}
