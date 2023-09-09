import 'package:args/command_runner.dart';

import '../../../../repositories/students_dio_repository.dart';
import '../../../../repositories/students_repository.dart';

class FindByIdCommand extends Command {
  final StudentsDioRepository repository;

  @override
  String get description => 'Find by student id';

  @override
  String get name => 'findById';

  FindByIdCommand(this.repository) {
    argParser.addOption('id', help: 'Student id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print('por favor envie o id do aluno com o comando --id=0 ou -i 0');
      return;
    }

    final id = int.parse(argResults?['id']);

    print('Aguarde buscando o aluno...');

    final student = await repository.findById(id);
    print('=======================================');
    print('Aluno: ${student.id} - ${student.name}');
    print('Idade: ${student.age}');
    print('Cursos:');
    student.nameCourses.forEach(print);
    print(
        'Endereço: ${student.address.city.name}, ${student.address.street} , CEP: ${student.address.zipCode}');
    print('=======================================');
  }
}
