import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric OpenSideDrawerStep() {
  return given<FlutterWorld>('I open the side drawer', (context) async {
    final location = find.byTooltip('Open navigation menu');
    await FlutterDriverUtils.tap(context.world.driver, location);
  });
}
