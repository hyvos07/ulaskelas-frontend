part of '_repositories.dart';

abstract class SemesterRepository {
  String get gpa;
  Future<Decide<Failure, Parsed<List<SemesterModel>>>> getAllSemester();
  Future<Decide<Failure, Parsed<SemesterModel>>> getSemester(QuerySemester q);
  Future<Decide<Failure, Parsed<SemesterModel>>> postSemester(
    Map<String, dynamic> model,
  );
  Future<Decide<Failure, Parsed<SemesterModel>>> editSemester(
    Map<String, dynamic> model,
  );
  Future<Decide<Failure, Parsed<void>>> deleteSemester(QuerySemester q);
}
