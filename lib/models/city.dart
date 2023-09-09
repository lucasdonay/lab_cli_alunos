// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class City {
  int id;
  String name;

  City({
    required this.id,
    required this.name,
  });

  City copyWith({
    int? id,
    String? name,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'City(id: $id, name: $name)';

  @override
  bool operator ==(covariant City other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
