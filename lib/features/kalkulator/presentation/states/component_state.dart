part of '_states.dart';

class ComponentState{
  ComponentState() {
    final remoteDataSource = ComponentRemoteDataSourceImpl();
    _repo = ComponentRepositoryImpl(remoteDataSource);
  }

  late ComponentRepository _repo;
  List<ComponentModel>? _components;
  List<ComponentModel> get components => _components ?? [];

  bool hasReachedMax = false;
  bool? canGiveRecom;

  double totalScore = 0;
  int totalWeight = 0;
  double recommendedScore = 85;
  double maxPossibleScore = 100;
  int? target;
  int page = 1;

  String? cacheKey = 'component-state';

  bool getCondition() {
    print('data ${_components?.isNotEmpty}');
    return _components?.isNotEmpty ?? false;
  }

  Future<void> retrieveData(QueryComponent query) async {
    int? targetScore;

    final resp = await _repo.getAllComponent(query);
    resp.fold((failure) {
      return failure;
    }, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _components = result.data['components'];
      recommendedScore = result.data['recommended_score'];
      maxPossibleScore =  result.data['max_possible_score'];
      targetScore = result.data['target_score'];
    },);
    /////////////////////////////////////////////////////
    totalWeight = _components!.fold(
      0, (int num, e) => num + e.weight!.toInt(),);
    hasReachedMax = totalWeight >= 100;
    totalScore = _components!.fold(
      // ignore: prefer_int_literals
      0.0, 
      (double num, e) {
        if (e.score != null && e.score != -1.0) {
          return num + (e.weight!.toInt() / 100 * e.score!);
        }
        return num;
      },
    );
    if (hasReachedMax) {
      // ignore: avoid_bool_literals_in_conditional_expressions
      canGiveRecom = maxPossibleScore >= 55 ? true : false;
      target = 85;
      while (target! > maxPossibleScore &&  target! >= 55) {
        target = target! - 5;}
      if (targetScore != null) target = targetScore;
    } else {
      canGiveRecom = null;
    }
    /////////////////////////////////////////////////////
    componentRM.notify();
  }

  Future<void> deleteComponent(QueryComponent query) async {
    final resp = await _repo.deleteComponent(query);
    await resp.fold((failure) {
      ErrorMessenger('Komponen gagal dihapus')
          .show(ctx!);
    }, (result) async {
      SuccessMessenger('Komponen berhasil dihapus').show(ctx!);
    });
  }

  void setTarget(int newTarget) {
    target = newTarget;
  }
}
