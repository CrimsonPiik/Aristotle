import 'dart:convert';
import 'dart:io';
import 'package:aristotle/generalFunctions/random_id_generator.dart';
import 'package:aristotle/models/address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

///This function is for reverse geocoding coordinates into human readable CustomerAddresses
Future<Address> reverseGeocode(LatLng coordinates) async {
  // String language = RhinoLanguage.isLTR() ? 'en' : 'ar';
  Uri url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinates.latitude},${coordinates.longitude}&key=AIzaSyAQ3NyP2_wexFITFpK2PQrLpZNtcxgC3t8&language=en');

  var responseJson;
  try {
    final response = await get(url);
    responseJson = jsonDecode(response.body);
  } on SocketException {
    print(' No Internet connection');
    throw ('No Internet connection');
  }

  var locationDetailsMap = {
    'userId': '',
    'formatedAddress': responseJson["results"][1]["formatted_address"],
    'country': responseJson["results"][0]["address_components"][3]["long_name"],
    'city': responseJson["results"][0]["address_components"][0]["long_name"],
    'neighbourhood': responseJson["results"][0]["address_components"][1]
        ["long_name"],
  };

  return Address.fromMap(locationDetailsMap);
}

///To create an Address from Latitude and Longtitude
Future<Address> humanReadableAddress(
  LatLng position,
  Address userAddress,
) async {
  Address address = Address();

  address.addressId = generateId();
  address.formattedAddress = userAddress.formattedAddress;
  address.country = userAddress.country;
  address.city = userAddress.city;
  address.neighbourhood = userAddress.neighbourhood;
  address.road = userAddress.road;
  address.latitude = position.latitude.toString();
  address.longitude = position.longitude.toString();

  return address;
}
