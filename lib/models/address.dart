// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'city.dart';
import 'phone.dart';

class Address {
  final String street;
  final int number;
  final String zipCode;
  final City city;
  final Phone phone;

  Address({
    required this.street,
    required this.number,
    required this.zipCode,
    required this.city,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'zipCode': zipCode,
      'city': city.toMap(),
      'phone': phone.toMap(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      number: map['number'] ?? 5,
      zipCode: map['zipCode'] ?? '',
      city: City.fromMap(map['city'] ?? <String, dynamic>{}),
      phone: Phone.fromMap(map['phone'] ?? <String, dynamic>{}),
    );
  }

  factory Address.fromJson(String json) => Address.fromMap(jsonDecode(json));

  @override
  String toString() {
    return 'Adress(street: $street, number: $number, zipCode: $zipCode, city: $city, phone: $phone)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.street == street &&
        other.number == number &&
        other.zipCode == zipCode &&
        other.city == city &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return street.hashCode ^
        number.hashCode ^
        zipCode.hashCode ^
        city.hashCode ^
        phone.hashCode;
  }
}
