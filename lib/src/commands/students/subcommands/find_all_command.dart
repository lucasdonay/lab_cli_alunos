import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../../repositories/students_dio_repository.dart';
import '../../../../repositories/students_repository.dart';

class FindAllCommand extends Command {
  final StudentsDioRepository repository;

  @override
  String get description => 'Find all students';

  @override
  String get name => 'findAll';

  FindAllCommand(this.repository);

  @override
  Future<void> run() async {
    print('Aguarde buscando alunos...');

    final students = await repository.findAll();

    print('Apresentar também os cursos? (S ou N)');

    final showCourses = stdin.readLineSync();
    print('=======================================');
    print('Alunos:');
    print('=======================================');
    for (var student in students) {
      final courses = showCourses?.toLowerCase() == 's'
          ? student.courses
              .where((course) => course.isStudent)
              .map((e) => e.name)
              .toList()
          : '';

      print('${student.id} - ${student.name} $courses');
    }
  }
}
