import 'package:args/command_runner.dart';
import 'package:lab_cli_alunos/src/commands/students/students_command.dart';


void main(List<String> arguments) {
  CommandRunner('ADF CLI', 'ADF CLI')
    ..addCommand(StudentsCommand())
    ..run(arguments);
}
