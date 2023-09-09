import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:lab_cli_alunos/models/address.dart';
import 'package:lab_cli_alunos/models/city.dart';
import 'package:lab_cli_alunos/models/phone.dart';
import 'package:lab_cli_alunos/models/students.dart';

import '../../../../repositories/products_dio_repository.dart';
import '../../../../repositories/products_repository.dart';
import '../../../../repositories/students_dio_repository.dart';
import '../../../../repositories/students_repository.dart';

class InsertCommand extends Command {
  final StudentsDioRepository repository;
  final productsRepository = ProductsDioRepository();

  @override
  String get description => 'Insert student';

  @override
  String get name => 'insert';

  InsertCommand(this.repository) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
  }

  @override
  Future<void> run() async {
    print('Aguarde...');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync();
    print('--------------------');

    for (var student in students) {
      final studentData = student.split(';');
      final courseCsv = studentData[2].split(',').map((e) => e.trim()).toList();

      final couseFutures = courseCsv.map((e) async {
        final course = await productsRepository.findByName(e);
        course.isStudent = true;
        return course;
      });

      final courses = await Future.wait(couseFutures);

      final studentModel = Student(
        name: studentData[0],
        age: int.tryParse(studentData[1]),
        nameCourses: courseCsv,
        courses: courses,
        address: Address(
          street: studentData[3],
          number: int.parse(studentData[4]),
          zipCode: studentData[5],
          city: City(id: 1, name: studentData[6]),
          phone: Phone(ddd: int.parse(studentData[7]), phone: studentData[8]),
        ),
      );

      await repository.insert(studentModel);
    }
    print('Alunos adicionados');
  }
}
