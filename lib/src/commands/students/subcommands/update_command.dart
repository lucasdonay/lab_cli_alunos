import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:lab_cli_alunos/repositories/products_repository.dart';
import 'package:lab_cli_alunos/repositories/students_repository.dart';

import '../../../../models/address.dart';
import '../../../../models/city.dart';
import '../../../../models/phone.dart';
import '../../../../models/students.dart';
import '../../../../repositories/products_dio_repository.dart';
import '../../../../repositories/students_dio_repository.dart';

class UpdateCommand extends Command {
  StudentsDioRepository studentsRepository;
  final productRepository = ProductsDioRepository();

  @override
  String get description => 'Update Student';

  @override
  String get name => 'update';

  UpdateCommand(this.studentsRepository) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
    argParser.addOption('id', help: 'Student id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    print('Aguarde...');
    final filePath = argResults?['file'];
    final id = argResults?['id'];
    print('--------------------');

    if (id == null) {
      print('Favor informar o id do aluno com o comando --id=0 ou -i 0');
      return;
    }
    final students = File(filePath).readAsLinesSync();

    print('Aguarde...');
    print('--------------------');

    if (students.length > 1) {
      print('Por favor informe somente um aluno pra excluir');
      return;
    } else if (students.isEmpty) {
      print('Por favor informe somente um aluno no arquivo $filePath');
      return;
    }

    var student = students.first;

    final studentData = student.split(';');
    final courseCsv = studentData[2].split(',').map((e) => e.trim()).toList();

    final couseFutures = courseCsv.map((e) async {
      final course = await productRepository.findByName(e);
      course.isStudent = true;
      return course;
    });

    final courses = await Future.wait(couseFutures);

    final studentModel = Student(
      id: int.parse(id),
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

    await studentsRepository.update(studentModel);
    print('Aluno atualizado com sucesso');
    print('--------------------');
  }
}
