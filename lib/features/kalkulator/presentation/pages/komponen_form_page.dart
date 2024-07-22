part of '_pages.dart';

class ComponentFormPage extends StatefulWidget {
  const ComponentFormPage({
    required this.calculatorId,
    required this.courseName,
    required this.totalScore,
    required this.totalPercentage,
    super.key,
  });

  final int calculatorId;
  final String courseName;
  final double totalScore;
  final double totalPercentage;

  @override
  _ComponentFormPageState createState() => _ComponentFormPageState();
}

class _ComponentFormPageState extends BaseStateful<ComponentFormPage> {
  @override
  void init() {
    componentFormRM.setState((s) => s.cleanForm());
    componentFormRM.state.previousFrequency = '1';
    componentFormRM.state.frequency.text = '1';
    componentFormRM.state.justVisited = true;

    print(componentFormRM.state.scoreControllers);
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Tambah Komponen Nilai',
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
        OnReactive(
          () => SimpanButton(
            isLoading: componentFormRM.state.isLoading,
            text: 'Simpan',
            onTap: () async {
              await onSubmitCallBack(context);
            },
          ),
        ),
      ],
    );
  }

  double _temporaryUpdateScore(
    double newScore,
    double newWeight,
  ) {
    return widget.totalScore + (newScore * newWeight / 100);
  }

  double _temporaryUpdateWeight(double newWeight) {
    return widget.totalPercentage + newWeight;
  }

  Future<void> onSubmitCallBack(BuildContext context) async {
    final currentFocus = FocusScope.of(context);
    componentFormRM.state.justVisited = false;
    componentFormRM.state.emptyScoreDetect();

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (componentFormRM.state.isLoading) {
      return;
    }
    MixpanelService.track('calculator_add_course_component');
    if (componentFormRM.state.formKey.currentState!.validate() &&
        !componentFormRM.state.scoreControllers
            .any((element) => element.text.isEmpty)) {
      // progressDialogue(context);
      await componentFormRM.state.submitForm(widget.calculatorId);
      await Future.delayed(const Duration(milliseconds: 150));

      nav.pop();

      final averageScore = componentFormRM.state.averageScore();
      final weight = componentFormRM.state.formData.weight!;

      componentFormRM.state.cleanForm();
      componentFormRM.state.emptyScoreDetect();
      if (kDebugMode) {
        print('success');
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
    componentFormRM.state.emptyScoreDetect();
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
              onControllerEmpty: () => componentFormRM.state.scoreControllers
                  .add(TextEditingController()),
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
