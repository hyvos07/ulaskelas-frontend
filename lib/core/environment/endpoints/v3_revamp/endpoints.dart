part of '../../_environment.dart';

class EndpointsRevamp {
  static String baseUrl = Config.baseConfig.endpoints.baseUrl;
  // Calculator Revamp
  static final semesters = '$baseUrl/api/calculator-gpa';
  static final courses = '$baseUrl/api/course-semester';
  static final components = '$baseUrl/api/course-component';
  static final subcomponents = '$baseUrl/api/course-subcomponent';
  static final autofill = '$baseUrl/api/calculator-gpa?is_auto_fill=true';
  static final tanyaTeman = '$baseUrl/api/tanya-teman';
  static final jawabTeman = '$baseUrl/api/jawab-teman';
  static final likePost = '$baseUrl/api/tanya-teman?is_like=true';
  static final likeReply = '$baseUrl/api/jawab-teman?is_like=true';
}
