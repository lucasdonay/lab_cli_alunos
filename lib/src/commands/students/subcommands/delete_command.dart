import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:lab_cli_alunos/repositories/students_repository.dart';

import '../../../../repositories/students_dio_repository.dart';

class DeleteCommand extends Command {
  StudentsDioRepository studentsRepository;
  @override
  String get description => 'Delete student id';

  @override
  String get name => 'delete';

  DeleteCommand(this.studentsRepository) {
    argParser.addOption('id', help: 'Student id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    if (argResults?['id'] == null || argResults?['id'] == '') {
      print(
          'Favor digitar o id do usuario que gostaria deletar usando o --id=0 ou -i 0');
    }

    final id = int.parse(argResults?['id']);

    print('Aguarde buscando o aluno...');

    final student = await studentsRepository.findById(id);

    print('Confirma a exclusao do aluno ${student.name} ? (Sim ou Não)');

    final confirmDelete = stdin.readLineSync();

    if (confirmDelete?.toLowerCase() == 's') {
      await studentsRepository.deleteById(id);
      print('Aluno deletado com sucesso.');
    } else {
      print('OK operação cancelada.');
    }
  }
}
