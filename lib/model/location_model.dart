class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({
    this.latitude,
    this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: double.parse(json['lat']),
      longitude: double.parse(json['lng']),
    );
  }
}
