// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'address.dart';
import 'courses.dart';

class Student {
  final int id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<Courses> courses;
  final Address address;

  Student({
    required this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Student copyWith({
    int? id,
    String? name,
    int? age,
    List<String>? nameCourses,
    List<Courses>? courses,
    Address? address,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      nameCourses: nameCourses ?? this.nameCourses,
      courses: courses ?? this.courses,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'nameCourses': nameCourses,
      'courses': courses.map((x) => x.toMap()).toList(),
      'address': address.toMap(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      age: map['age'] != null ? map['age'] as int : null,
      nameCourses: List<String>.from((map['nameCourses'] ?? <String>[])),
      courses: map['courses']
              ?.map<Courses>((cursoMap) => Courses.fromMap(cursoMap))
              .toList() ??
          <Courses>[],
      address: Address.fromMap(map['address'] ?? <String, dynamic>{}),
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, name: $name, age: $age, nameCourses: $nameCourses, courses: $courses, adress: $address)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        other.age == age &&
        listEquals(other.nameCourses, nameCourses) &&
        listEquals(other.courses, courses) &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        age.hashCode ^
        nameCourses.hashCode ^
        courses.hashCode ^
        address.hashCode;
  }
}
