import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric enrolledAtLeastNCourseStep() {
  return given<FlutterWorld>('I am enrolled in at least 1 course',
      (context) async {
    final location = find.byValueKey('course-card');
    await FlutterDriverUtils.isPresent(context.world.driver, location);
  });
}
