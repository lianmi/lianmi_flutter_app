import 'package:geolocator/geolocator.dart';
import 'package:lianmiapp/models/my_location_model.dart';
import 'package:lianmiapp/provider/location_provider.dart';
import 'package:lianmiapp/util/app.dart';
import 'package:provider/provider.dart';

class LocationUtils {
  ///获取两点之间的距离
  static double getdistanceInMeters(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distanceInMeters;
  }

  ///获取当前定位到商户的距离
  static String showShopDistance(double latitude, double longitude) {
    MyLocationModel myLocation =
        Provider.of<LocationProvider>(App.appContext!, listen: false)
            .loadMyLastLocation();
    if (myLocation.longitude == 0 && myLocation.latitude == 0) {
      return '>2km';
    }
    double distance = LocationUtils.getdistanceInMeters(
        latitude, longitude, myLocation.latitude!, myLocation.longitude!);
    if (distance < 100) {
      return '<100m';
    } else if (distance > 2000) {
      return '>2km';
    } else {
      return '${distance.toStringAsFixed(0)}m';
    }
  }
}
