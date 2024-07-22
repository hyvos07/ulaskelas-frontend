part of '_pages.dart';

class EditComponentPage extends StatefulWidget {
  const EditComponentPage({
    required this.id,
    required this.calculatorId,
    required this.courseName,
    required this.totalScore,
    required this.totalPercentage,
    required this.componentName,
    required this.componentScore,
    required this.componentWeight,
    super.key,
  });

  final int id;
  final int calculatorId;
  final String courseName;
  final double totalScore;
  final double totalPercentage;
  final String componentName;
  final double componentScore;
  final double componentWeight;

  @override
  _EditComponentPageState createState() => _EditComponentPageState();
}

class _EditComponentPageState extends BaseStateful<EditComponentPage> {
  @override
  void init() {
    componentFormRM.setState((s) => s.cleanForm());
    componentFormRM.state.nameController.text = widget.componentName;
    componentFormRM.state.weightController.text =
        widget.componentWeight.toString();
    componentFormRM.setState(
      (s) => {
        s.scoreControllers.last.text = widget.componentScore.toStringAsFixed(2),
        s.setScore(1),
      },
    );
    print(componentFormRM.state.scoreControllers);
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Edit Komponen',
      onBackPress: onBackPressed,
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return Column(
      children: [
        Expanded(
          child: Form(
            key: componentFormRM.state.formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildNameField(),
                const HeightSpace(20),
                _buildWeightField(),
                const HeightSpace(20),
                _buildScoreField(),
              ],
            ),
          ),
        ),
        Center(
          child: InkWell(
            onTap: () {
              nav.pop();

              componentFormRM.state.cleanForm();
              componentFormRM.state.emptyScoreDetect();
              if (kDebugMode) {
                print('Hapus Komponen');
              }

              componentRM.setState(
                (s) => s.deleteComponent(
                  QueryComponent(id: widget.id),
                ),
              );

              nav.replaceToComponentPage(
                calculatorId: widget.calculatorId,
                courseName: widget.courseName,
                totalScore: widget.totalScore -
                    (widget.componentScore * widget.componentWeight / 100),
                totalPercentage:
                    widget.totalPercentage - widget.componentWeight,
              );
            },
            child: Text(
              'Hapus Komponen Nilai',
              style: FontTheme.poppins14w500black().copyWith(
                color: BaseColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const HeightSpace(30),
        OnReactive(
          () => SimpanButton(
            isLoading: componentFormRM.state.isLoading,
            text: 'Simpan Perubahan',
            onTap: () async {
              await onSubmitCallBack(context);
            },
          ),
        ),
      ],
    );
  }

  Future<void> onSubmitCallBack(BuildContext context) async {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (componentFormRM.state.isLoading) {
      return;
    }
    if (componentFormRM.state.formKey.currentState!.validate()) {
      await componentFormRM.state.submitEditForm(
        widget.id,
        widget.calculatorId,
      );
      await Future.delayed(const Duration(milliseconds: 150));

      nav.pop();

      final averageScore = componentFormRM.state.averageScore();
      final weight = componentFormRM.state.formData.weight!;

      componentFormRM.state.cleanForm();
      componentFormRM.state.emptyScoreDetect();
      if (kDebugMode) {
        print('Hapus Komponen');
      }

      await nav.replaceToComponentPage(
        calculatorId: widget.calculatorId,
        courseName: widget.courseName,
        totalScore: _temporaryUpdateScore(
          averageScore,
          weight,
        ),
        totalPercentage: _temporaryUpdateWeight(
          weight,
        ),
      );
      return;
    }
    WarningMessenger('Harap isi semua field').show(context);
  }

  TextFormField _buildNameField() {
    return TextFormField(
      controller: componentFormRM.state.nameController,
      minLines: 1,
      style: FontTheme.poppins12w400black(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        // constraints: const BoxConstraints(maxHeight: 12.5 * 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: 'Nama Komponen',
      ),
      textInputAction: TextInputAction.newline,
      onChanged: (value) {
        if (value.trim().isEmpty) {
          componentFormRM.state.nameController.text = '';
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        componentFormRM.setState((s) => s.setName());
        return null;
      },
    );
  }

  TextFormField _buildWeightField() {
    return TextFormField(
      controller: componentFormRM.state.weightController,
      minLines: 1,
      style: FontTheme.poppins12w400black(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9]+[,.]{0,1}[0-9]*')),
      ],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        // constraints: const BoxConstraints(maxHeight: 12.5 * 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: 'Bobot (%)',
      ),
      onChanged: (value) {
        if (value.trim().isEmpty) {
          componentFormRM.state.weightController.clear();
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        componentFormRM.setState((s) => s.setWeight());
        return null;
      },
    );
  }

  Widget _buildScoreField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 5,
            top: 5,
            bottom: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Frekuensi',
                style: FontTheme.poppins14w400black().copyWith(
                  fontSize: 13,
                ),
              ),
              FrequencyController(
                onIncrease: () => componentFormRM.state.increaseFrequency(),
                onDecrease: () => componentFormRM.state.decreaseFrequency(),
                onChangingValue: (value, isExceed) =>
                    componentFormRM.state.setFrequency(value, isExceed),
                frequencyController: componentFormRM.state.frequency,
              )
            ],
          ),
        ),
        const HeightSpace(10),
        OnBuilder<ComponentFormState>.all(
          listenTo: componentFormRM,
          onIdle: () => const CircleLoading(),
          onWaiting: () => const CircleLoading(),
          onError: (error, refresh) => Text(error.toString()),
          onData: (data) {
            return ScoresFieldInput(
              averageScoreCalculation: () =>
                  componentFormRM.state.averageScore(),
              onControllerEmpty: () {
                componentFormRM.state.scoreControllers
                    .add(TextEditingController());
                componentFormRM.state.scoreControllers[0].text =
                    widget.componentScore.toStringAsFixed(2);
                componentFormRM.state.setScore(1);
              },
              subtitle: componentFormRM.state.isEmptyScoreDetected
                  ? Text(
                      'Terdapat nilai yang belum diisi',
                      style: FontTheme.poppins10w400black().copyWith(
                        color: BaseColors.error,
                        fontSize: 11,
                      ),
                    )
                  : null,
              onFieldSubmitted: (value, index) => {
                componentFormRM.state.justVisited = false,
                componentFormRM.state.emptyScoreDetect(),
                componentFormRM.state.setScore(index),
              },
              controllers: componentFormRM.state.scoreControllers,
              length: int.tryParse(componentFormRM.state.frequency.text) ?? 1,
            );
          },
        ),
      ],
    );
  }

  double _temporaryUpdateScore(
    double newScore,
    double newWeight,
  ) {
    return widget.totalScore -
        (widget.componentScore * widget.componentWeight / 100) +
        (newScore * newWeight / 100);
  }

  double _temporaryUpdateWeight(double newWeight) {
    return widget.totalPercentage - widget.componentWeight + newWeight;
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  Future<bool> onBackPressed() async {
    componentFormRM.state.previousFrequency = '1';
    componentFormRM.state.cleanForm();
    componentFormRM.state.emptyScoreDetect();
    nav.pop<void>();
    return true;
  }
}
