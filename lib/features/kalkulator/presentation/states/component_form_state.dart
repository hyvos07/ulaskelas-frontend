part of '_states.dart';

class ComponentFormState {
  ComponentFormState() {
    final remoteDataSource = ComponentRemoteDataSourceImpl();
    _repo = ComponentRepositoryImpl(
      remoteDataSource,
    );
    _frequency.text = '1';
  }

  late ComponentRepository _repo;
  final formKey = GlobalKey<FormState>();
  var _formData = ComponentData();
  final _nameController = TextEditingController();
  final _scoreControllers = <TextEditingController>[TextEditingController()];
  final _weightController = TextEditingController();
  final _frequency = TextEditingController();

  String _previousFrequency = '1';
  double _recommendedScore = 85;
  bool isLoading = false;
  bool justVisited = true;

  /// Get details information of passed component
  Future<void> retrieveDetailedComponent(QueryComponent q) async {
    final resp = await _repo.getDetailComponent(q);
    resp.fold((failure) {
      throw failure;
    }, (result) {
      final detail = result.data;
      _frequency.text = detail['frequency'].toString();
      _scoreControllers.clear();
      for (var i = 0; i < int.parse(_frequency.text); i++) {
        _scoreControllers.add(TextEditingController());
        scoreControllers.last.text =
            detail['scores'][i] == null ? '' : detail['scores'][i].toString();
        _formData.score![i + 1] = detail['scores'][i];
      }
      _recommendedScore = detail['recommended_score']?.toDouble() ?? 85;
      justVisited = true;
    });
  }

  /// Submitting form data
  Future<void> submitForm(int calculatorId) async {
    isLoading = true;
    componentFormRM.notify();
    final result = <String, dynamic>{};

    result['calculator_id'] = calculatorId;
    result['name'] = _formData.name;
    result['weight'] = _formData.weight;
    result['frequency'] = int.parse(_frequency.text);
    result['scores'] = _formData.score!.values.toList();

    final resp = await _repo.createComponent(result);
    isLoading = false;
    componentFormRM.notify();
    resp.fold((failure) {
      throw failure;
    }, (result) {
      final successSubmittedComponent = result.data;
      print(successSubmittedComponent);
    });
  }

  Future<void> submitEditForm(int id) async {
    isLoading = true;
    componentFormRM.notify();
    final result = <String, dynamic>{};

    result['score_component_id'] = id;
    result['name'] = _formData.name;
    result['weight'] = _formData.weight;
    result['frequency'] = int.parse(_frequency.text);
    result['scores'] = _formData.score!.values.toList();

    final resp = await _repo.editComponent(result);
    isLoading = false;
    componentFormRM.notify();
    resp.fold((failure) {
      throw failure;
    }, (result) {
      final successEditedComponent = result.data;
      print(successEditedComponent);
    });
  }

  ComponentData get formData => _formData;
  double get recommendedScore => _recommendedScore;

  TextEditingController get nameController => _nameController;
  List<TextEditingController> get scoreControllers => _scoreControllers;
  TextEditingController get weightController => _weightController;
  TextEditingController get frequency => _frequency;

  set previousFrequency(String value) => _previousFrequency = value;

  void setName() {
    _formData.name = nameController.text;
  }

  void setScore(int index) {
    _formData.score![index] =
        double.tryParse(scoreControllers[index - 1].text);

    if (kDebugMode) {
      print('Form Data: ${_formData.score}');
    }
  }

  void setWeight() {
    _formData.weight = double.parse(weightController.text);
  }

  /// Cleaning form when success submitting form
  void cleanForm() {
    _formData = ComponentData();
    _formData.score = <int, double?>{};

    _nameController.text = '';
    _weightController.text = '';

    setFrequency(1, false);
    for (final element in _scoreControllers) {
      element.clear();
    }

    justVisited = true;
  }

  void decreaseFrequency() {
    final currentLength = int.parse(_frequency.text);

    _formData.score!.remove(currentLength);

    _frequency.text = (currentLength - 1).toString();
    _scoreControllers.removeLast();

    if (kDebugMode) {
      print('Frequency: ${_frequency.text}');
      print('Form Data: ${_formData.score}');
    }

    _previousFrequency = _frequency.text;

    componentFormRM.notify();
  }

  void increaseFrequency() {
    _frequency.text = (int.parse(_frequency.text) + 1).toString();
    _scoreControllers.add(TextEditingController());

    _formData.score![int.parse(_frequency.text)] = null;

    if (kDebugMode) {
      print('Frequency: ${_frequency.text}');
      print('Form Data: ${_formData.score}');
    }

    _previousFrequency = _frequency.text;

    componentFormRM.notify();
  }

  void setFrequency(int value, bool isExceed) {
    if (isExceed) {
      _frequency.text = _previousFrequency;
    } else {
      _frequency.text = value.toString();

      if (_scoreControllers.length != value) {
        if (_scoreControllers.length > value) {
          _scoreControllers.removeRange(value, _scoreControllers.length);
          _formData.score!.removeWhere((key, _) => key > value);
        } else {
          _scoreControllers.addAll(
            List.generate(
              value - _scoreControllers.length,
              (_) => TextEditingController(),
            ),
          );
        }
      }

      for (var i = 1; i < value + 1; i++) {
        _formData.score!.putIfAbsent(i, () => null);
      }
    }

    if (kDebugMode) {
      print('Frequency: ${_frequency.text}');
      print('Form Data: ${_formData.score}');
    }

    _previousFrequency = _frequency.text;

    componentFormRM.notify();
  }

  double? averageScore() {
    var sum = 0.0;
    var valid = 0;

    final length = int.tryParse(_frequency.text) ?? 1;

    for (var i = 0; i < length; i++) {
      sum += double.tryParse(_scoreControllers[i].text) ?? 0;
      valid++;
    }
    return sum != 0 && valid != 0 ? sum / valid : null;
  }
}

class ComponentData {
  String? name;
  Map<int, double?>? score;
  double? weight;
}
