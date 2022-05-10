import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric enrolledInNStep() {
  return given1<String, FlutterWorld>('I am enrolled in {string}',
      (course, context) async {
    final location = find.byValueKey(course);
    await FlutterDriverUtils.isPresent(context.world.driver, location);
  });
}
