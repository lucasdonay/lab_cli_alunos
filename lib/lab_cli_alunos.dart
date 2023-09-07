import 'package:lab_cli_alunos/src/repositories/students_repository.dart';

Future<void> main() async {
  final studentsRepository = StudentsRepository();

  final studentAll = await studentsRepository.findAll();

  print(studentAll);

  final studentId = await studentsRepository.findById(1);
  print(studentId);
}
