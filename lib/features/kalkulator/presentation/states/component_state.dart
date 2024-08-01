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
  double totalScore = 0;
  int totalWeight = 0;
  int page = 1;

  String? cacheKey = 'component-state';

  bool getCondition() {
    print('data ${_components?.isNotEmpty}');
    return _components?.isNotEmpty ?? false;
  }

  Future<void> retrieveData(QueryComponent query) async {
    final resp = await _repo.getAllComponent(query);
    resp.fold((failure) {
      return failure;
    }, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _components = result.data;
      print(components);
    },);
    /////////////////////////////////////////////////////
    totalWeight = _components!.fold(
      0, (int num, e) => num + e.weight!.toInt(),);
    hasReachedMax = totalWeight >= 100;
    totalScore = _components!.fold(
      // ignore: prefer_int_literals
      0.0, (double num, e) => num + (e.weight!.toInt() / 100 * e.score!),);
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
}
