

class Locations {
  String place;
  double lat;
  double lng;
  Locations(
      {
        required this.place,
        required this.lat,
        required this.lng});

  factory Locations.fromJson(Map<String, dynamic> map) {
    return Locations(
      place: map['place'],
      lng: map['longitude'],
      lat: map['latitude']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'place': place,
      'longitude': lng,
      'latitude': lat,
    };
  }

}
Locations nullplace = Locations(place: "nullplace",lat: 0.0,lng: 0.0);


