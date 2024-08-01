part of '_repositories.dart';

abstract class SemesterRepository {
  String get gpa;
  Future<Decide<Failure, Parsed<List<SemesterModel>>>> getSemesters();
  Future<Decide<Failure, Parsed<List<SemesterModel>>>> postSemester(
    List<String> givenSemesters,
  );
  Future<Decide<Failure, Parsed<void>>> deleteSemester(QuerySemester q);
  Future<Decide<Failure, Parsed<List<SemesterModel>>>> getAutoFillSemester();
  Future<Decide<Failure, Parsed<SemesterModel>>> postAutoFillSemester(
    Map<String, dynamic> model,
  );
}
