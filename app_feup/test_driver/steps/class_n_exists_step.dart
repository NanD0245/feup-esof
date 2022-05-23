import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric classNExistsStep() {
  return given1<String, FlutterWorld>('the class {string} exists',
      (courseClass, context) async {
    final location = find.byValueKey(courseClass);
    await FlutterDriverUtils.isPresent(context.world.driver, location);
  });
}
