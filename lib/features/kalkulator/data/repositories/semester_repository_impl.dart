part of '_repositories.dart';

class SemesterRepositoryImpl extends SemesterRepository {
  SemesterRepositoryImpl(
    this._remoteDataSource,
  );

  final SemesterRemoteDataSource _remoteDataSource;
  
  @override
  String get gpa => _remoteDataSource.gpa;

  @override
  Future<Decide<Failure, Parsed<List<SemesterModel>>>> getSemesters() {
    return apiCall(_remoteDataSource.getSemesters());
  }

  @override
  Future<Decide<Failure, Parsed<List<SemesterModel>>>> postSemester(
    List<String> givenSemesters,
  ) {
    return apiCall(_remoteDataSource.postSemester(givenSemesters));
  }

  @override
  Future<Decide<Failure, Parsed<void>>> deleteSemester(QuerySemester q) {
    return apiCall(_remoteDataSource.deleteSemester(q));
  }
}
