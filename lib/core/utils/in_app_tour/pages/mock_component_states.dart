part of '_pages.dart';

/// Mock of the real one, only for showcase
class MockComponentState {
  List<ComponentModel>? _components;
  List<ComponentModel> get components => _components ?? [];

  bool hasReachedMax = false;
  bool canGiveRecom = false;
  bool canPass = true;
  bool allScoreFilled = false;
  bool componentChange = true;

  double totalScore = 0;
  int totalWeight = 0;
  double recommendedScore = 85;
  double maxPossibleScore = 100;
  int? target;
  int page = 1;

  String? cacheKey = 'mock-component-state';

  bool getCondition() {
    print('data ${_components?.isNotEmpty}');
    return _components?.isNotEmpty ?? false;
  }

  Future<void> retrieveData(QueryComponent query) async {
    _components ??= [];

    if (componentChange) {
      componentChange = false;
      target = null;
    }
    if (target != null) {
      query.targetScore = target;
    }

    hasReachedMax = _components?.isEmpty ?? true;
    if (firstComponentFilled && secondComponentFilled) {
      recommendedScore = 100;
      maxPossibleScore = 100;
    } else {
      recommendedScore = 0;
      for (final component in _components!) {
        maxPossibleScore += component.weight!.toInt();
      }
    }

    totalWeight = _components!.fold(
      0,
      (int num, e) => num + e.weight!.toInt(),
    );
    hasReachedMax = totalWeight >= 100;
    totalScore = _components!.fold(
      0,
      (double num, e) {
        if (e.score != null && e.score != -1.0) {
          return num + (e.weight!.toInt() / 100 * e.score!);
        }
        return num;
      },
    );
    if (hasReachedMax) {
      allScoreFilled = components.every((i) => i.score != -1);
      canGiveRecom = maxPossibleScore >= 55 && allScoreFilled == false;
      if (canGiveRecom) {
        if (target == null) {
          target = 85;
          while (target! > maxPossibleScore && target! >= 55) {
            target = target! - 5;
          }
        }
        canPass = true;
      } else {
        target = 85;
        canPass = false;
      }
    } else {
      target = 85;
      canGiveRecom = false;
    }

    mockComponentRM.notify();
  }

  Future<void> addComponent(int step, int calculatorId) async {
    await retrieveData(QueryComponent(calculatorId: calculatorId));

    switch (step) {
      case 1:
        _components?.add(
          ComponentModel(
            id: 1,
            calculatorId: calculatorId,
            name: 'UTS',
            weight: 50,
            score: 70,
            frequency: 1,
          ),
        );
        firstComponentFilled = true;
      case 2:
        _components?.add(
          ComponentModel(
            id: 2,
            calculatorId: calculatorId,
            name: 'UAS',
            weight: 50,
            score: -1,
            frequency: 1,
          ),
        );
        secondComponentFilled = true;
      default:
        break;
    }
    await retrieveData(QueryComponent(calculatorId: calculatorId));
    mockComponentRM.notify();
  }

  Future<void> deleteComponent(int step) async {
    switch (step) {
      case 1:
        _components?.removeWhere((comp) => comp.id == 1);
        firstComponentFilled = false;
      case 2:
        _components?.removeWhere((comp) => comp.id == 2);
        secondComponentFilled = false;
      default:
        break;
    }
    await retrieveData(QueryComponent(calculatorId: 9999));
    mockComponentRM.notify();
  }

  void setTarget(int newTarget) {
    target = newTarget;
  }
}
