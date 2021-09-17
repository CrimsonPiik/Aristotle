import 'dart:convert';

import 'package:aristotle/generalFunctions/random_id_generator.dart';

class Address {
  String addressId = generateId();

  String userId = '';
  String formattedAddress = '';
  String country = '';
  String city = '';
  String neighbourhood = '';
  String road = '';
  String latitude = '31.964860';
  String longitude = '35.842991';
  Address();

  Map<String, dynamic> toMap() {
    return {
      'addressId': addressId,
      'userId': userId,
      'formattedAddress': formattedAddress,
      'country': country,
      'city': city,
      'neighbourhood': neighbourhood,
      'road': road,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  Address.fromMap(Map<String, dynamic> map)
      : addressId = map['addressId'] ?? '',
        userId = map['userId'] ?? '',
        formattedAddress = map['formattedAddress'] ?? '',
        country = map['country'] ?? '',
        city = map['city'] ?? '',
        neighbourhood = map['neighbourhood'] ?? '',
        road = map['road'] ?? '',
        latitude = map['latitude'] ?? '31.964860',
        longitude = map['longitude'] ?? '35.842991';

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'formattedAddress: $formattedAddress, $country - $city - $neighbourhood - $road';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.addressId == addressId &&
        other.formattedAddress == formattedAddress &&
        other.userId == userId &&
        other.country == country &&
        other.city == city &&
        other.neighbourhood == neighbourhood &&
        other.road == road &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return addressId.hashCode ^
        formattedAddress.hashCode ^
        userId.hashCode ^
        country.hashCode ^
        city.hashCode ^
        neighbourhood.hashCode ^
        road.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
