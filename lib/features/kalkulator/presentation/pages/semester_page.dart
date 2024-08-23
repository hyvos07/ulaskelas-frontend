part of '_pages.dart';

class SemesterPage extends StatefulWidget {
  const SemesterPage({
    required this.givenSemester,
    required this.semesterGPA,
    required this.totalSKS,
    super.key,
  });

  final String? givenSemester;
  final double? semesterGPA;
  final int? totalSKS;

  @override
  _SemesterPageState createState() => _SemesterPageState();
}

class _SemesterPageState extends BaseStateful<SemesterPage> {
  String get semesterName {
    if (widget.givenSemester!.contains('sp')) {
      return 'SP ${widget.givenSemester!.substring(3)}';
    }
    return 'Semester ${widget.givenSemester}';
  }

  @override
  void init() {
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: calculatorRM.state.getCondition(),
      cacheKey: calculatorRM.state.cacheKey!,
    ).initialize();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Pref.getBool('doneAppTour') == false ||
          Pref.getBool('doneAppTour') == null) {
        showcaseSemesterPage();
      }
    });
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Kalkulator Nilai - $semesterName',
      onBackPress: onBackPressed,
    );
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  Widget buildNarrowLayout(BuildContext context, SizingInformation sizeInfo) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: retrieveData,
        key: refreshIndicatorKey,
        child: OnBuilder<CalculatorState>.all(
          listenTo: calculatorRM,
          onWaiting: WaitingView.new,
          onIdle: WaitingView.new,
          onError: (dynamic error, refresh) => Text(error.toString()),
          onData: (data) {
            final calculators = data.calculators;
            if (calculators.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeightSpace(sizeInfo.screenSize.height * .05),
                    Image.asset(
                      Ilustration.notfound,
                      width: sizeInfo.screenSize.width * .6,
                    ),
                    const HeightSpace(20),
                    Text(
                      'Belum Ada Mata Kuliah yang Tersimpan',
                      style: FontTheme.poppins14w700black().copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const HeightSpace(10),
                    Text(
                      'Kamu belum menambahkan satupun mata kuliah. '
                      '\nSilakan tambahkan terlebih dahulu.',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const HeightSpace(50),
                    _addButton(),
                  ],
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 27.5,
                    bottom: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        semesterName,
                        style: FontTheme.poppins14w700black(),
                      ),
                      Text(
                        calculatorRM.state.gpa,
                        style: FontTheme.poppins14w700black(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shrinkWrap: true,
                    itemCount: calculatorRM.state.calculators.length + 1,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      if (index == calculators.length) {
                        return _addButton();
                      }
                      final calculator = calculators[index];
                      if (index == 0) {
                        return ShowCaseWidget(
                          builder: (context) {
                            semesterContext = context;
                            return Showcase.withWidget(
                              key: inAppTourKeys.courseCardGC,
                              overlayColor: BaseColors.neutral100,
                              overlayOpacity: 0.5,
                              targetPadding: const EdgeInsets.all(12),
                              targetBorderRadius: BorderRadius.circular(10),
                              blurValue: 1,
                              height: 0,
                              width: MediaQuery.of(context).size.width,
                              disposeOnTap: false,
                              disableBarrierInteraction: true,
                              disableMovingAnimation: true,
                              onTargetClick: () async {
                                ShowCaseWidget.of(context).dismiss();
                                nav.pop();
                                backToMatkulCalcPage =
                                    () => nav.goToComponentCalculatorPage(
                                          givenSemester: widget.givenSemester!,
                                          courseId: calculator.courseId!,
                                          calculatorId: calculator.id!,
                                          courseName: calculator.courseName!,
                                          totalScore: calculator.totalScore!,
                                          totalPercentage:
                                              calculator.totalPercentage!,
                                        );
                                backFromNavbarProfile = false;
                                backToMatkulCalcPage();
                              },
                              container: courseCardGCShowcase(context),
                              child: CardCalculator(
                                model: calculator,
                                givenSemester: widget.givenSemester!,
                                onTap: () => nav.goToComponentCalculatorPage(
                                  givenSemester: widget.givenSemester!,
                                  courseId: calculator.courseId!,
                                  calculatorId: calculator.id!,
                                  courseName: calculator.courseName!,
                                  totalScore: calculator.totalScore!,
                                  totalPercentage: calculator.totalPercentage!,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return CardCalculator(
                        model: calculator,
                        givenSemester: widget.givenSemester!,
                        onTap: () => nav.goToComponentCalculatorPage(
                          givenSemester: widget.givenSemester!,
                          courseId: calculator.courseId!,
                          calculatorId: calculator.id!,
                          courseName: calculator.courseName!,
                          totalScore: calculator.totalScore!,
                          totalPercentage: calculator.totalPercentage!,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
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
    calculatorRM.state.calculators.clear();
    await semesterRM.state.retrieveData();
    return true;
  }

  Future<void> retrieveData() async {
    await calculatorRM.setState(
      (s) => s.retrieveData(widget.givenSemester!),
    );
  }

  Widget _addButton() {
    return Column(
      children: [
        const HeightSpace(25),
        SecondaryButton(
          width: double.infinity,
          text: 'Tambah Mata Kuliah',
          backgroundColor: BaseColors.purpleHearth,
          onPressed: () =>
              nav.goToSearchCourseCalculatorPage(widget.givenSemester!),
        ),
        const HeightSpace(25),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () async {
                // For now, the dialog will buy some time for the buggy flushbar
                await Future.delayed(const Duration(milliseconds: 250));
                await showDialog(
                  context: context,
                  builder: (context) => DeleteDialog(
                    title: 'Hapus Semester',
                    content: 'Apakah kamu yakin ingin menghapus $semesterName?',
                    onConfirm: () async {
                      nav
                        ..pop()
                        ..pop();
                      await semesterRM.setState(
                        (s) => s.deleteSemester(
                          query: QuerySemester(
                            givenSemester: widget.givenSemester,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              child: Text(
                'Hapus Semester ini',
                style: FontTheme.poppins14w500black().copyWith(
                  color: BaseColors.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        const HeightSpace(30),
      ],
    );
  }
}
