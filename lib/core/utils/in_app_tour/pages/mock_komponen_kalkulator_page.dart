part of '_pages.dart';

class MockCalculatorComponentPage extends StatefulWidget {
  const MockCalculatorComponentPage({
    required this.givenSemester,
    required this.calculatorId,
    required this.courseId,
    required this.courseName,
    required this.totalScore,
    required this.totalPercentage,
    required this.courseSKS,
    super.key,
  });

  final String givenSemester;
  final int calculatorId;
  final int courseId;
  final String courseName;
  final double totalScore;
  final double totalPercentage;
  final int courseSKS;

  @override
  _MockCalculatorComponentPageState createState() =>
      _MockCalculatorComponentPageState();
}

class _MockCalculatorComponentPageState
    extends BaseStateful<MockCalculatorComponentPage> {
  late ScrollController scrollController;

  @override
  void init() {
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: false,
      cacheKey: mockComponentRM.state.cacheKey!,
    ).initialize();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!backFromNavbarProfile) {
        showcaseComponentPage();
      } else {
        showcaseFinalScoreComponent();
      }
    });
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
    '55',
  ];

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return ShowCaseWidget(
      builder: (context) {
        matkulCalcContext = context;
        return RefreshIndicator(
          onRefresh: retrieveData,
          key: refreshIndicatorKey,
          child: OnBuilder<MockComponentState>.all(
            listenTo: mockComponentRM,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.courseName,
                                style: FontTheme.poppins20w700black(),
                              ),
                              const HeightSpace(4),
                              Text(
                                '${widget.courseSKS} SKS',
                                style: FontTheme.poppins16w500black().copyWith(
                                  color: BaseColors.gray2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ShowcaseWrapper(
                          showcaseKey: inAppTourKeys.incompleteComponentGC,
                          targetPadding: const EdgeInsets.all(10),
                          targetBorderRadius: BorderRadius.circular(10),
                          container: incompleteComponentGCShowcase(
                            context,
                            goToComponentCreationPage,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Nilai Akhir',
                                    style: FontTheme.poppins14w400black(),
                                  ),
                                  Text(
                                    _getFinalScoreAndGrade(
                                      mockComponentRM.state.totalScore,
                                    ),
                                    style: FontTheme.poppins14w600black(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ShowcaseWrapper(
                                showcaseKey: inAppTourKeys.finalScoreGC,
                                targetPadding: const EdgeInsets.fromLTRB(
                                  10,
                                  10,
                                  10,
                                  0,
                                ),
                                targetBorderRadius: BorderRadius.circular(10),
                                container: finalScoreGCShowcase(context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Target',
                                          style: FontTheme.poppins14w400black(),
                                        ),
                                        ShowcaseWrapper(
                                          showcaseKey:
                                              inAppTourKeys.targetScoreGC,
                                          targetPadding:
                                              const EdgeInsets.all(10),
                                          targetBorderRadius:
                                              BorderRadius.circular(10),
                                          container: targetScoreShowcase(
                                            context,
                                            goToComponentCreationPage,
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/star.svg',
                                                // ignore: deprecated_member_use
                                                height: 23,
                                                width: 23,
                                                color: mockComponentRM.state
                                                            .hasReachedMax &&
                                                        mockComponentRM
                                                            .state.canGiveRecom
                                                    ? null
                                                    : BaseColors.gray1
                                                        .withOpacity(0.3),
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              TargetScoreDropdown(
                                                nilaiHarapanList:
                                                    _nilaiHarapanList,
                                                voidWhenHasntReacedhMax: () {
                                                  if (!mockComponentRM
                                                      .state.hasReachedMax) {
                                                    ErrorMessenger(
                                                      'Total bobot harus mencapai 100%',
                                                    ).show(context);
                                                  } else if (!mockComponentRM
                                                      .state.canGiveRecom) {
                                                    if (mockComponentRM
                                                        .state.allScoreFilled) {
                                                      print(
                                                        mockComponentRM.state
                                                            .allScoreFilled,
                                                      );
                                                      ErrorMessenger(
                                                        'Semua nilai komponen sudah '
                                                        'terisi',
                                                      ).show(context);
                                                    } else if (!mockComponentRM
                                                        .state.canPass) {
                                                      ErrorMessenger(
                                                        'Nilai tidak dapat mencapai '
                                                        'minimal target',
                                                      ).show(context);
                                                    }
                                                  }
                                                },
                                                voidWhenReachedMax:
                                                    mockComponentRM.state
                                                                .hasReachedMax &&
                                                            mockComponentRM
                                                                .state
                                                                .canGiveRecom
                                                        ? (String? newValue) {
                                                            mockComponentRM
                                                                .state
                                                                .setTarget(
                                                              int.parse(
                                                                  newValue!),
                                                            );
                                                            retrieveData();
                                                          }
                                                        : null,
                                                canGiveRecom: mockComponentRM
                                                    .state.canGiveRecom,
                                                hasReachedMax: mockComponentRM
                                                    .state.hasReachedMax,
                                                target: mockComponentRM
                                                    .state.target,
                                                maxPossibleScore:
                                                    mockComponentRM
                                                        .state.maxPossibleScore,
                                              ),
                                            ],
                                          ),
                                        ),
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
                                            isGradient: mockComponentRM
                                                    .state.hasReachedMax &&
                                                mockComponentRM
                                                    .state.canGiveRecom,
                                            componentStyle: mockComponentRM
                                                        .state.hasReachedMax &&
                                                    mockComponentRM
                                                        .state.canGiveRecom
                                                ? null
                                                : FontTheme.poppins12w600black()
                                                    .copyWith(
                                                    color: BaseColors.gray1
                                                        .withOpacity(0.3),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (components.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: Center(
                                          child: Text(
                                            'Belum Ada Komponen',
                                            style:
                                                FontTheme.poppins12w500black()
                                                    .copyWith(
                                              color: BaseColors.gray3,
                                            ),
                                          ),
                                        ),
                                      )
                                    else
                                      ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(top: 20),
                                        itemCount: mockComponentRM
                                            .state.components.length,
                                        itemBuilder: (context, index) {
                                          final component = components[index];
                                          return CardCompononent(
                                            id: component.id!,
                                            name: component.name!,
                                            score: component.score,
                                            weight: component.weight!,
                                            hope: mockComponentRM
                                                        .state.hasReachedMax &&
                                                    mockComponentRM
                                                        .state.canGiveRecom
                                                ? mockComponentRM
                                                    .state.recommendedScore
                                                : null,
                                            onTap: () {
                                              goToEditComponentPage(component);
                                            },
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const SizedBox(height: 1),
                                      ),
                                  ],
                                ),
                              ),
                              const HeightSpace(5),
                              ShowcaseWrapper(
                                showcaseKey: inAppTourKeys.totalComponentGC,
                                tooltipPosition: TooltipPosition.bottom,
                                targetPadding: const EdgeInsets.all(12),
                                targetBorderRadius: BorderRadius.circular(10),
                                container: totalComponentGCShowcase(context),
                                child: Column(
                                  children: [
                                    CustomTableRow(
                                      components: [
                                        CustomTableRowComponent(
                                          flexRatio: 50,
                                          text:
                                              '${mockComponentRM.state.components.length} '
                                              'Komponen',
                                        ),
                                        CustomTableRowComponent(
                                          flexRatio: 25,
                                          text: mockComponentRM.state.totalScore
                                              .toStringAsFixed(2),
                                        ),
                                        CustomTableRowComponent(
                                          flexRatio: 25,
                                          text:
                                              '${mockComponentRM.state.totalWeight.toStringAsFixed(0)}%',
                                        ),
                                        CustomTableRowComponent(
                                          flexRatio: 30,
                                          text: mockComponentRM
                                                      .state.hasReachedMax &&
                                                  mockComponentRM
                                                      .state.canGiveRecom
                                              ? mockComponentRM.state.target!
                                                  .toStringAsFixed(2)
                                              : '',
                                          isGradient: true,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    if (!mockComponentRM
                                        .state.hasReachedMax) ...[
                                      const HeightSpace(30),
                                      _buildWarningComponent(),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const HeightSpace(35),
                        ShowcaseWrapper(
                          showcaseKey: inAppTourKeys.addComponentGC,
                          tooltipPosition: TooltipPosition.bottom,
                          targetPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          targetBorderRadius: BorderRadius.circular(10),
                          container: addComponentGCShowcase(
                            context,
                            goToComponentCreationPage,
                          ),
                          onTargetClick: () {
                            ShowCaseWidget.of(context).dismiss();
                            goToComponentCreationPage();
                          },
                          child: SecondaryButton(
                            width: double.infinity,
                            text: 'Tambah Komponen',
                            backgroundColor: BaseColors.purpleHearth,
                            onPressed: goToComponentCreationPage,
                          ),
                        ),
                        const HeightSpace(40),
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
      },
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
        content: 'Apakah kamu yakin ingin menghapus '
            'Kalkulator ${widget.courseName}?',
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
      courseSKS: widget.courseSKS,
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
      courseSKS: widget.courseSKS,
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
    await mockComponentRM.setState(
      (s) => s.retrieveData(
        QueryComponent(
          calculatorId: widget.calculatorId,
        ),
      ),
    );
  }

  Widget _buildWarningComponent() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: BaseColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: BaseColors.neutral100.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/ruby/ruby_sad.png',
            height: 42,
          ),
          const WidthSpace(12),
          Expanded(
            child: Text(
              'Total bobot belum 100%. '
              'Lengkapi dulu agar Ruby bisa memberi rekomendasi.',
              style: FontTheme.poppins14w600black().copyWith(fontSize: 10),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
