part of '_repositories.dart';

class SemesterRepositoryImpl extends SemesterRepository {
  SemesterRepositoryImpl(
    this._remoteDataSource,
  );

  final SemesterRemoteDataSource _remoteDataSource;
  
  @override
  String get gpa => _remoteDataSource.gpa!;

  @override
  Future<Decide<Failure, Parsed<List<SemesterModel>>>> getAllSemester() {
    return apiCall(_remoteDataSource.getAllSemester());
  }

  @override
  Future<Decide<Failure, Parsed<SemesterModel>>> getSemester(QuerySemester q) {
    return apiCall(_remoteDataSource.getSemester(q));
  }

  @override
  Future<Decide<Failure, Parsed<SemesterModel>>> postSemester(
    Map<String, dynamic> model,
  ) {
    return apiCall(_remoteDataSource.postSemester(model));
  }

  @override
  Future<Decide<Failure, Parsed<SemesterModel>>> editSemester(
      Map<String, dynamic> model,) {
    return apiCall(_remoteDataSource.editSemester(model));
  }

  @override
  Future<Decide<Failure, Parsed<void>>> deleteSemester(QuerySemester q) {
    return apiCall(_remoteDataSource.deleteSemester(q));
  }
}
