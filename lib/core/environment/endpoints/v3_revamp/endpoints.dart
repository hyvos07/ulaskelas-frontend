part of '../../_environment.dart';

class EndpointsRevamp {
  static String baseUrl = Config.baseConfig.endpoints.baseUrl;
  // Calculator Revamp
  static final semesters = '$baseUrl/api/calculator-gpa';
  static final courses = '$baseUrl/api/course-semester';
  static final components = '$baseUrl/api/course-component';
}
