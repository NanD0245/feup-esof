import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/course_units/course_unit.dart';
import 'package:uni/model/entities/course_units/course_unit_classes.dart';
import 'package:uni/model/entities/course_units/course_unit_materials.dart';
import 'package:uni/model/entities/course_units/course_unit_sheet.dart';
import 'package:uni/model/entities/exam.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/entities/profile.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/model/entities/session.dart';
import 'package:uni/model/entities/trip.dart';
import 'package:uni/model/home_page_model.dart';

import '../model/app_state.dart';
import '../model/entities/bus_stop.dart';

class SaveLoginDataAction {
  Session session;
  SaveLoginDataAction(this.session);
}

class SetLoginStatusAction {
  RequestStatus status;
  SetLoginStatusAction(this.status);
}

class SetExamsAction {
  List<Exam> exams;
  SetExamsAction(this.exams);
}

class SetExamsStatusAction {
  RequestStatus status;
  SetExamsStatusAction(this.status);
}

class SetCourseUnitSheetsAction {
  List<CourseUnitSheet> courseUnitsSheets;
  SetCourseUnitSheetsAction(this.courseUnitsSheets);
}

class SetCourseUnitSheetsStatusAction {
  RequestStatus status;
  SetCourseUnitSheetsStatusAction(this.status);
}

class SetCourseUnitClassesAction {
  List<CourseUnitClasses> courseUnitsClasses;
  SetCourseUnitClassesAction(this.courseUnitsClasses);
}

class SetCourseUnitClassesStatusAction {
  RequestStatus status;
  SetCourseUnitClassesStatusAction(this.status);
}

class SetCourseUnitMaterialsAction {
  List<CourseUnitMaterials> courseUnitsMaterials;
  SetCourseUnitMaterialsAction(this.courseUnitsMaterials);
}

class SetCourseUnitMaterialsStatusAction {
  RequestStatus status;
  SetCourseUnitMaterialsStatusAction(this.status);
}

class SetRestaurantsAction {
  List<Restaurant> restaurants;
  SetRestaurantsAction(this.restaurants);
}

class SetRestaurantsStatusAction {
  RequestStatus status;
  SetRestaurantsStatusAction(this.status);
}

class SetScheduleAction {
  List<Lecture> lectures;
  SetScheduleAction(this.lectures);
}

class SetScheduleStatusAction {
  RequestStatus status;
  SetScheduleStatusAction(this.status);
}

class SetInitialStoreStateAction {
  SetInitialStoreStateAction();
}

class SaveProfileAction {
  Profile profile;
  SaveProfileAction(this.profile);
}

class SaveProfileStatusAction {
  RequestStatus status;
  SaveProfileStatusAction(this.status);
}

class SaveCurrUcsAction {
  List<CourseUnit> ucs;
  SaveCurrUcsAction(this.ucs);
}

class SetPrintBalanceAction {
  String printBalance;
  SetPrintBalanceAction(this.printBalance);
}

class SetPrintBalanceStatusAction {
  RequestStatus status;
  SetPrintBalanceStatusAction(this.status);
}

class SetFeesBalanceAction {
  String feesBalance;
  SetFeesBalanceAction(this.feesBalance);
}

class SetFeesLimitAction {
  String feesLimit;
  SetFeesLimitAction(this.feesLimit);
}

class SetFeesStatusAction {
  RequestStatus status;
  SetFeesStatusAction(this.status);
}

class SetCoursesStatesAction {
  Map<String, String> coursesStates;
  SetCoursesStatesAction(this.coursesStates);
}

class SetBusTripsAction {
  Map<String, List<Trip>> trips;
  SetBusTripsAction(this.trips);
}

class SetBusStopsAction {
  Map<String, BusStopData> busStops;
  SetBusStopsAction(this.busStops);
}

class SetBusTripsStatusAction {
  RequestStatus status;
  SetBusTripsStatusAction(this.status);
}

class SetBusStopTimeStampAction {
  DateTime timeStamp;
  SetBusStopTimeStampAction(this.timeStamp);
}

class SetCurrentTimeAction {
  DateTime currentTime;
  SetCurrentTimeAction(this.currentTime);
}

class UpdateFavoriteCards {
  List<FAVORITE_WIDGET_TYPE> favoriteCards;
  UpdateFavoriteCards(this.favoriteCards);
}

class SetCoursesStatesStatusAction {
  RequestStatus status;
  SetCoursesStatesStatusAction(this.status);
}

class SetPrintRefreshTimeAction {
  String time;
  SetPrintRefreshTimeAction(this.time);
}

class SetFeesRefreshTimeAction {
  String time;
  SetFeesRefreshTimeAction(this.time);
}

class SetHomePageEditingMode {
  bool state;
  SetHomePageEditingMode(this.state);
}

class SetLastUserInfoUpdateTime {
  DateTime currentTime;
  SetLastUserInfoUpdateTime(this.currentTime);
}

class SetExamFilter {
  Map<String, bool> filteredExams;
  SetExamFilter(this.filteredExams);
}

class SetUserFaculties {
  List<String> faculties;
  SetUserFaculties(this.faculties);
}
