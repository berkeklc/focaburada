import 'package:focaburada/model/model.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class MapService {
  static final MapService instance = MapService._internal();

  factory MapService() => instance;

  MapService._internal();

  final Location _location = Location.instance;

  String createDirectionURL({
    LocationModel origin,
    LocationModel destination,
  }) {
    String url =
        "https://www.google.com/maps/dir/${origin.latitude}, ${origin.longitude}/${destination.latitude}, ${destination.longitude}/";

    return url;
  }

  Future<bool> launchDirections(LocationModel destination) async {
    if (destination == null) return false;

    bool hasPermission = await requestPermission();

    if (!hasPermission) return false;

    LocationModel currentLocation = await getCurrentLocation();

    if (currentLocation == null) return false;

    String directionUrl = createDirectionURL(
      origin: currentLocation,
      destination: destination,
    );

    launchUrl(Uri.parse(directionUrl));

    return true;
  }

  Future<bool> hasLocationPermission() async {
    PermissionStatus permission = await _location.hasPermission();

    bool isGranted = permission == PermissionStatus.granted ||
        permission == PermissionStatus.grantedLimited;

    return isGranted;
  }

  Future<bool> requestPermission() async {
    bool hasPermission = await hasLocationPermission();

    if (hasPermission) return true;

    await _location.requestPermission();

    return await hasLocationPermission();
  }

  Future<LocationModel> getCurrentLocation() async {
    LocationData locationData = await _location.getLocation();

    if (locationData == null) return null;

    return LocationModel(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
    );
  }
}
