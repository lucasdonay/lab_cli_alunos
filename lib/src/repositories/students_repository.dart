import 'dart:convert';

import '../models/students.dart';
import 'package:http/http.dart' as http;

class StudentsRepository {
  Future<List<Student>> findAll() async {
    final studentResponse =
        await http.get(Uri.parse('http://localhost:8080/students'));
    final studentList = jsonDecode(studentResponse.body);

    return studentList.map<Student>((student) {
      return Student.fromMap(student);
    }).toList();
  }

  Future<Student> findById(int id) async {
    final studentResponse =
        await http.get(Uri.parse('http://localhost:8080/students/$id'));

    return Student.fromJson(studentResponse.body);
  }

  Future<void> insert(Student student) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/students'),
      body: student.toJson(),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao criar aluno');
    }
  }

  Future<void> update(Student student) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/students/${student.id}'),
      body: student.toJson(),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar aluno');
    }
  }

  Future<void> deleteById(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar usuario');
    }
  }
}
