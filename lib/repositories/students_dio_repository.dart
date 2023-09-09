import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/students.dart';
import 'package:http/http.dart' as http;

class StudentsDioRepository {
  Future<List<Student>> findAll() async {
    try {
      final studentResponse =
          await Dio().get('http://localhost:8080/students');

      return studentResponse.data.map<Student>((student) {
        return Student.fromMap(student);
      }).toList();
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Student> findById(int id) async {
    try {
      final studentResponse =
          await Dio().get('http://localhost:8080/students/$id');

      if (studentResponse.data == null) {
        throw Exception();
      }

      return Student.fromMap(studentResponse.data);
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
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
