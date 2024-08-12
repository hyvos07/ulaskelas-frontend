part of '_pages.dart';

class CalculatorComponentPage extends StatefulWidget {
  const CalculatorComponentPage({
    required this.givenSemester,
    required this.calculatorId,
    required this.courseId,
    required this.courseName,
    required this.totalScore,
    required this.totalPercentage,
    super.key,
  });

  final String givenSemester;
  final int calculatorId;
  final int courseId;
  final String courseName;
  final double totalScore;
  final double totalPercentage;

  @override
  _CalculatorComponentPageState createState() =>
      _CalculatorComponentPageState();
}

class _CalculatorComponentPageState
    extends BaseStateful<CalculatorComponentPage> {
  late ScrollController scrollController;
  Completer<void>? completer;

  @override
  void init() {
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: false,
      cacheKey: componentRM.state.cacheKey!,
    ).initialize();
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Tambah Nilai Mata Kuliah',
      onBackPress: onBackPressed,
    );
  }

  final List<String> _nilaiHarapanList = [
    '85',
    '80',
    '75',
    '70',
    '65',
    '60',
    '55'
  ];

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return RefreshIndicator(
      onRefresh: retrieveData,
      key: refreshIndicatorKey,
      child: OnBuilder<ComponentState>.all(
        listenTo: componentRM,
        onIdle: () => const SizedBox.shrink(),
        onWaiting: () => const SizedBox.shrink(),
        onError: (dynamic error, refresh) => Text(error.toString()),
        onData: (data) {
          final components = data.components;
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        widget.courseName,
                        style: FontTheme.poppins20w700black(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nilai Akhir',
                          style: FontTheme.poppins14w400black(),
                        ),
                        Text(
                          _getFinalScoreAndGrade(widget.totalScore),
                          style: FontTheme.poppins14w600black(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Target',
                          style: FontTheme.poppins14w400black(),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              // ignore: deprecated_member_use
                              height: 23,
                              width: 23,
                              color: componentRM.state.hasReachedMax
                                && componentRM.state.canGiveRecom!
                                  ? null
                                  : BaseColors.gray1.withOpacity(0.3),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            TargetScoreDropdown(
                              nilaiHarapanList: _nilaiHarapanList,
                              voidWhenHasntReacedhMax: () {
                                if (!componentRM.state.hasReachedMax) {
                                  ErrorMessenger(
                                    'Total bobot harus mencapai 100%',
                                  ).show(context);
                                } else if (!componentRM.state.canGiveRecom) {
                                  if (componentRM.state.allScoreFilled) {
                                    print(componentRM.state.allScoreFilled);
                                    ErrorMessenger(
                                      'Semua nilai komponen sudah terisi',
                                    ).show(context);
                                  } else if (!componentRM.state.canPass) {
                                    ErrorMessenger(
                                      'Nilai tidak dapat mencapai minimal target',
                                    ).show(context);
                                  } 
                                }
                              },
                              voidWhenReachedMax: componentRM.state.hasReachedMax
                                && componentRM.state.canGiveRecom
                                  ? (String? newValue) {
                                      componentRM.state.setTarget(
                                        int.parse(newValue!)
                                      );
                                      retrieveData();
                                    }
                                  : null,
                              canGiveRecom: componentRM.state.canGiveRecom,
                              hasReachedMax: componentRM.state.hasReachedMax, 
                              target: componentRM.state.target, 
                              maxPossibleScore: componentRM.state.maxPossibleScore
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: CustomTableRow(
                        components: [
                          CustomTableRowComponent(
                            flexRatio: 25,
                            text: 'Komponen',
                          ),
                          CustomTableRowComponent(
                            flexRatio: 10,
                            text: 'Nilai',
                          ),
                          CustomTableRowComponent(
                            flexRatio: 12,
                            text: 'Bobot',
                          ),
                          CustomTableRowComponent(
                            flexRatio: 0,
                            text: 'Rekomendasi',
                            isGradient: componentRM.state.hasReachedMax 
                                  && componentRM.state.canGiveRecom!,
                            componentStyle: componentRM.state.hasReachedMax   
                                  && componentRM.state.canGiveRecom!
                                ? null
                                : FontTheme.poppins12w600black().copyWith(
                                    color: BaseColors.gray1.withOpacity(0.3),
                                  ),
                          )
                        ],
                      ),
                    ),
                    if (components.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Center(
                          child: Text(
                            'Belum Ada Komponen',
                            style: FontTheme.poppins12w500black().copyWith(
                              color: BaseColors.gray3,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 20),
                        itemCount: componentRM.state.components.length,
                        itemBuilder: (context, index) {
                          final component = components[index];
                          return CardCompononent(
                            id: component.id!,
                            name: component.name!,
                            score: component.score,
                            weight: component.weight!,
                            hope: componentRM.state.hasReachedMax
                              && componentRM.state.canGiveRecom
                                ? componentRM.state.recommendedScore
                                : null,
                            onTap: () {
                              goToEditComponentPage(component);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 1),
                      ),
                    const HeightSpace(5),
                    CustomTableRow(
                      components: [
                        CustomTableRowComponent(
                          flexRatio: 50,
                          text:
                              '${componentRM.state.components.length} Komponen',
                        ),
                        CustomTableRowComponent(
                          flexRatio: 25,
                          text: componentRM.state.totalScore.toStringAsFixed(2),
                        ),
                        CustomTableRowComponent(
                          flexRatio: 25,
                          text:
                              '${componentRM.state.totalWeight.toStringAsFixed(0)}%',
                        ),
                        CustomTableRowComponent(
                          flexRatio: 30,
                          text: componentRM.state.hasReachedMax
                            && componentRM.state.canGiveRecom
                              ? componentRM.state.target!
                                  .toStringAsFixed(2)
                              : '',
                          isGradient: true,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    const HeightSpace(30),
                    SecondaryButton(
                      width: double.infinity,
                      text: 'Tambah Komponen',
                      backgroundColor: BaseColors.purpleHearth,
                      onPressed: goToComponentCreationPage,
                    ),
                    const HeightSpace(70),
                    Center(
                      child: InkWell(
                        onTap: deleteCourse,
                        child: Text(
                          'Hapus Kalkulator Mata Kuliah',
                          style: FontTheme.poppins14w500black().copyWith(
                            color: BaseColors.error,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
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
    nav.pop();
    await calculatorRM.state.retrieveData(widget.givenSemester);
    return true;
  }

  Future<void> deleteCourse() async {
    await showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        title: 'Hapus Matkul',
        content:
            'Apakah kamu yakin ingin menghapus Kalkulator ${widget.courseName}?',
        onConfirm: () async {
          nav
            ..pop()
            ..pop();
          await calculatorRM.setState(
            (s) => s.deleteCalculator(
              query: QueryCalculator(
                courseId: widget.courseId,
              ),
              givenSemester: widget.givenSemester,
              courseName: widget.courseName,
              totalScore: widget.totalScore,
            ),
          );
        },
      ),
    );
  }

  void goToComponentCreationPage() {
    nav.goToComponentFormPage(
      givenSemester: widget.givenSemester,
      courseId: widget.courseId,
      calculatorId: widget.calculatorId,
      courseName: widget.courseName,
      totalScore: widget.totalScore < 0 ? 0 : widget.totalScore,
      totalPercentage: widget.totalPercentage,
    );
  }

  void goToEditComponentPage(ComponentModel component) {
    print(widget.totalScore);
    nav.goToEditComponentPage(
      id: component.id!,
      givenSemester: widget.givenSemester,
      courseId: widget.courseId,
      calculatorId: widget.calculatorId,
      courseName: widget.courseName,
      totalScore: widget.totalScore < 0 ? 0 : widget.totalScore,
      totalPercentage: widget.totalPercentage,
      componentName: component.name!,
      componentScore: component.score! < 0 ? 0 : component.score!,
      componentWeight: component.weight!,
    );
  }

  String _getFinalScoreAndGrade(double score) {
    var grade = 'E';
    if (score >= 85) {
      grade = 'A';
    } else if (score >= 80) {
      grade = 'A-';
    } else if (score >= 75) {
      grade = 'B+';
    } else if (score >= 70) {
      grade = 'B';
    } else if (score >= 65) {
      grade = 'B-';
    } else if (score >= 60) {
      grade = 'C+';
    } else if (score >= 55) {
      grade = 'C';
    } else if (score >= 40) {
      grade = 'D';
    }

    return '$grade (${score.toStringAsFixed(2)})';
  }

  Future<void> retrieveData() async {
    await componentRM.setState(
      (s) => s.retrieveData(
        componentRM.state.target == null
          ? QueryComponent(
              calculatorId: widget.calculatorId,
            )
          : QueryComponent(
              calculatorId: widget.calculatorId,
              targetScore: componentRM.state.target
            ),
      ),
    );
  }
}
