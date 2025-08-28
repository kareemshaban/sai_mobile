import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class LocationService {
  static Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBarWidget(message: AppStrings.pleaseEnableLocation);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBarWidget(message: AppStrings.pleaseEnableLocation);

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBarWidget(message: AppStrings.pleaseEnableLocationFromSettings);

      return false;
    }
    return true;
  }

  static Future<Position?> getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return null;
    var location = await Geolocator.getCurrentPosition();
    return location;
  }

  static Future<Placemark> getAddressFromLatLng(Position position) async {
    var placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMark[0];
    return place;
  }
}
