import 'package:args/command_runner.dart';
import 'package:lab_cli_alunos/src/commands/students/subcommands/delete_command.dart';
import 'package:lab_cli_alunos/src/commands/students/subcommands/find_all_command.dart';
import 'package:lab_cli_alunos/src/commands/students/subcommands/find_by_id_command.dart';
import 'package:lab_cli_alunos/src/commands/students/subcommands/insert_command.dart';
import 'package:lab_cli_alunos/src/commands/students/subcommands/update_command.dart';

import '../../../repositories/students_dio_repository.dart';
import '../../../repositories/students_repository.dart';

class StudentsCommand extends Command {
  @override
  String get description => 'Students Operations';

  @override
  String get name => 'students';

  StudentsCommand() {
    final studentRepository = StudentsDioRepository();
    addSubcommand(FindAllCommand(studentRepository));
    addSubcommand(FindByIdCommand(studentRepository));
    addSubcommand(InsertCommand(studentRepository));
    addSubcommand(UpdateCommand(studentRepository));
    addSubcommand(DeleteCommand(studentRepository));
  }
}
