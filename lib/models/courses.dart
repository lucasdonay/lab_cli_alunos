import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Courses {
  int id;
  String name;
  bool isStudent;

  Courses({
    required this.id,
    required this.name,
    required this.isStudent,
  });


  Courses copyWith({
    int? id,
    String? name,
    bool? isStudent,
  }) {
    return Courses(
      id: id ?? this.id,
      name: name ?? this.name,
      isStudent: isStudent ?? this.isStudent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isStudent': isStudent,
    };
  }

  factory Courses.fromMap(Map<String, dynamic> map) {
    return Courses(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      isStudent: (map['isStudent'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Courses.fromJson(String source) => Courses.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Courses(id: $id, name: $name, isStudent: $isStudent)';

  @override
  bool operator ==(covariant Courses other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.isStudent == isStudent;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isStudent.hashCode;
}
