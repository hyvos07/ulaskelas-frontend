part of '_pages.dart';

class EditComponentPage extends StatefulWidget {
  const EditComponentPage({
    required this.id,
    required this.givenSemester,
    required this.courseId,
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
  final String givenSemester;
  final int courseId;
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
      (s) => s.retrieveDetailedComponent(
        QueryComponent(
          scoreComponentId: widget.id,
        ),
      ),
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
        const HeightSpace(30),
        Center(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DeleteDialog(
                    title: 'Hapus Komponen Nilai',
                    content: 'Apakah Anda yakin ingin menghapus '
                        '${widget.componentName}?',
                    onConfirm: () {
                      nav
                        ..pop()
                        ..pop();

                      componentFormRM.state.cleanForm();
                      if (kDebugMode) {
                        print('Hapus Komponen');
                      }

                      componentRM.setState(
                        (s) => s.deleteComponent(
                          QueryComponent(id: widget.id),
                        ),
                      );

                      nav.replaceToComponentPage(
                        givenSemester: widget.givenSemester,
                        courseId: widget.courseId,
                        calculatorId: widget.calculatorId,
                        courseName: widget.courseName,
                        totalScore: widget.totalScore -
                            ((widget.componentScore < 0
                                    ? 0
                                    : widget.componentScore) *
                                widget.componentWeight /
                                100),
                        totalPercentage:
                            widget.totalPercentage - widget.componentWeight,
                      );
                    },
                  );
                },
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
    componentFormRM.state.justVisited = false;

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (componentFormRM.state.isLoading) {
      return;
    }

    final allIsEmpty = componentFormRM.state.averageScore() == null;
    final oneIsEmpty = componentFormRM.state.scoreControllers.any(
      (element) => element.text.isEmpty,
    );
    final isSingleSubcomponent =
        componentFormRM.state.scoreControllers.length == 1;

    if (componentFormRM.state.formKey.currentState!.validate() &&
        (!oneIsEmpty || allIsEmpty || isSingleSubcomponent)) {
      await componentRM.setState((s) => s.componentChange = true);
      await componentFormRM.state.submitEditForm(widget.id);
      await Future.delayed(const Duration(milliseconds: 150));

      nav.pop();

      final averageScore = componentFormRM.state.averageScore() ?? 0;
      final weight = componentFormRM.state.formData.weight!;

      componentFormRM.state.cleanForm();
      if (kDebugMode) {
        print('Hapus Komponen');
      }

      await nav.replaceToComponentPage(
        givenSemester: widget.givenSemester,
        courseId: widget.courseId,
        calculatorId: widget.calculatorId,
        courseName: widget.courseName,
        totalScore: _temporaryUpdateScore(
          averageScore < 0 ? 0 : averageScore,
          weight,
        ),
        totalPercentage: _temporaryUpdateWeight(
          weight,
        ),
      );
      return;
    }

    WarningMessenger('Pastikan semua field sudah terisi dengan benar!')
        .show(context);
  }

  Widget _buildNameField() {
    final recommendation = [
      'Tugas Individu',
      'Tugas Kelompok',
      'UTS',
      'UAS',
      'Kuis',
      'Partisipasi',
      'Refleksi'
    ];

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
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
        ),
        Positioned(
          right: 18,
          top: 15,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              customButton: SvgPicture.asset(
                SvgIcons.dropdown,
                width: 20,
                height: 20,
              ),
              items: List.generate(
                7,
                (index) => DropdownMenuItem(
                  value: recommendation[index],
                  child: Text(
                    recommendation[index],
                    style: FontTheme.poppins12w400black(),
                  ),
                ),
              ),
              onChanged: (value) {
                componentFormRM.state.nameController.text = value.toString();
                if (kDebugMode) {
                  print('You Choosed $value!');
                }
              },
              dropdownStyleData: DropdownStyleData(
                width: 135,
                direction: DropdownDirection.left,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: BaseColors.white,
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 38,
              ),
            ),
          ),
        ),
      ],
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
            left: 12,
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
        OnBuilder<ComponentFormState>.all(
          listenTo: componentFormRM,
          onIdle: () => const CircleLoading(),
          onWaiting: () => const CircleLoading(),
          onError: (error, refresh) => Text(error.toString()),
          onData: (data) {
            return Column(
              children: [
                HeightSpace(
                  componentFormRM.state.scoreControllers.length == 1 ? 25 : 10,
                ),
                if (data.scoreControllers.length == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: data.scoreControllers.first,
                          minLines: 1,
                          style: FontTheme.poppins12w400black(),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp('[0-9]+[,.]{0,1}[0-9]*'),
                            ),
                          ],
                          onFieldSubmitted: (value) => {
                            data.justVisited = false,
                            data.setScore(1),
                          },
                          onChanged: (value) {
                            if (value.trim().isEmpty) {
                              data.scoreControllers.first.clear();
                            }
                          },
                          validator: (value) {
                            if ((double.tryParse(value!) ?? 0) > 200) {
                              return "Score can't be more than 200";
                            }
                            componentFormRM.setState((s) => s.setScore(1));
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Nilai',
                          ),
                        ),
                      ),
                      if (componentRM.state.hasReachedMax &&
                          componentRM.state.canGiveRecom)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const WidthSpace(12),
                            RecommendedScoreBox(
                              value: componentFormRM.state.recommendedScore,
                              score: componentFormRM
                                  .state.scoreControllers.first.text,
                            ),
                          ],
                        ),
                    ],
                  )
                else
                  ScoresFieldInput(
                    recommendedScore: componentFormRM.state.recommendedScore,
                    showRecommendedScore: componentRM.state.hasReachedMax &&
                        componentRM.state.canGiveRecom,
                    averageScoreCalculation: () => data.averageScore() ?? 0,
                    onControllerEmpty: () =>
                        data.scoreControllers.add(TextEditingController()),
                    onFieldChanged: (value, index) => {
                      data.justVisited = false,
                      data.setScore(index),
                    },
                    controllers: data.scoreControllers,
                    length: int.tryParse(data.frequency.text) ?? 1,
                  ),
              ],
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
    print('Total Score: ${widget.totalScore}');
    print('Component Score: ${widget.componentScore}');
    print('Component Weight: ${widget.componentWeight}');
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
    nav.pop<void>();
    return true;
  }
}
