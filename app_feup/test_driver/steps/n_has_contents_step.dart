import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric nHasContentsStep() {
  return given1<String, FlutterWorld>('{String} has contents in SIGARRA',
      (courseClass, context) async {
    await Future(() async {
      return true;
    });
  });
}
