import 'dart:async';

import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import 'steps/class_n_exists_step.dart';
import 'steps/enrolled_at_least_n_course_step.dart';
import 'steps/enrolled_in_n_step.dart';
import 'steps/n_has_contents_step.dart';
import 'steps/n_has_no_contents_sigarra_step.dart';
import 'steps/open_side_drawer_step.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [RegExp('test_driver/features/*.*.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ] // you can include the "StdoutReporter()" without the message level
    //   parameter for verbose log information
    ..stepDefinitions = [
      enrolledAtLeastNCourseStep(),
      openSideDrawerStep(),
      enrolledInNStep(),
      classNExistsStep(),
      nHasContentsStep(),
      nHasNoContentsStep(),
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart';
  // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
  return GherkinRunner().execute(config);
}
