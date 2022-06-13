import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric nHasNoContentsStep() {
  return given1<String, FlutterWorld>(
      '{String} does not have contents in SIGARRA',
      (courseClass, context) async {
    await Future(() async {
      return true;
    });
  });
}
