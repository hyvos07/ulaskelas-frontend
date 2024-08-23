part of '_pages.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({
    super.key,
  });

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends BaseStateful<CalculatorPage> {
  final userGen = int.parse(profileRM.state.profile.generation!);

  @override
  void init() {
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: semesterRM.state.getCondition(),
      cacheKey: semesterRM.state.cacheKey!,
    ).initialize();
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      hasLeading: false,
      label: 'Kalkulator Nilai Mata Kuliah',
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return ShowCaseWidget(
      builder: (context) {
        calculatorContext = context;
        return SafeArea(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: retrieveData,
            child: OnBuilder<SemesterState>.all(
              listenTo: semesterRM,
              onIdle: WaitingView.new,
              onWaiting: WaitingView.new,
              onError: (dynamic error, refresh) => const Text('error'),
              onData: (data) {
                final semesters = data.semesters;
                if (semesters.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeightSpace(sizeInfo.screenSize.height * .05),
                          Image.asset(
                            Ilustration.notfound,
                            width: sizeInfo.screenSize.width * .55,
                          ),
                          const HeightSpace(20),
                          Showcase.withWidget(
                            key: inAppTourKeys.emptySemesterGC,
                            tooltipPosition: TooltipPosition.top,
                            overlayColor: BaseColors.neutral100,
                            overlayOpacity: 0.5,
                            targetPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            blurValue: 1,
                            height: 0,
                            width: MediaQuery.of(context).size.width,
                            disposeOnTap: false,
                            disableBarrierInteraction: true,
                            disableMovingAnimation: true,
                            onTargetClick: () {},
                            container: emptyCalcGCShowcase(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Belum Ada Nilai yang Tersimpan',
                                  style:
                                      FontTheme.poppins14w700black().copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const HeightSpace(10),
                                Text(
                                  'Kamu belum memiliki nilai semester.\n'
                                  'Silakan tambahkan terlebih dahulu.',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                                const HeightSpace(20),
                                _addSemesterButton(1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                semesters.sort(
                  (a, b) =>
                      _semesterPendekValueChanger(a.givenSemester!, userGen)
                          .compareTo(
                    _semesterPendekValueChanger(b.givenSemester!, userGen),
                  ),
                );
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Showcase.withWidget(
                        key: inAppTourKeys.filledSemesterGC,
                        overlayColor: BaseColors.neutral100,
                        overlayOpacity: 0.5,
                        targetPadding: const EdgeInsets.fromLTRB(
                          12,
                          10,
                          12,
                          185,
                        ),
                        targetBorderRadius: BorderRadius.circular(10),
                        blurValue: 1,
                        height: 0,
                        width: MediaQuery.of(context).size.width,
                        disposeOnTap: false,
                        disableBarrierInteraction: true,
                        disableMovingAnimation: true,
                        onTargetClick: () {},
                        container: filledCalcGCShowcase(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'IPK',
                              style: FontTheme.poppins16w400black(),
                            ),
                            Text(
                              semesterRM.state.cumulativeGPA,
                              style: FontTheme.poppins16w700black(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemCount: semesterRM.state.semesters.length + 1,
                        itemBuilder: (context, index) {
                          if (index == semesters.length) {
                            return _addSemesterButton(index + 1);
                          }
                          targetSemester = {
                            'givenSemester': semesters[0].givenSemester,
                            'semesterGPA': semesters[0].semesterGPA,
                            'totalSKS': semesters[0].totalSKS,
                          }; // Saving this for back button function
                          final semester = semesters[index];
                          return Column(
                            children: [
                              if (index == 0)
                                Showcase.withWidget(
                                  key: inAppTourKeys.semesterCardGC,
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
                                    await nav.goToSemesterPage(
                                      givenSemester: semester.givenSemester!,
                                      semesterGPA: semester.semesterGPA!,
                                      totalSKS: semester.totalSKS!,
                                    );
                                  },
                                  container: semesterCardGCShowcase(context),
                                  child: CardSemester(
                                    model: semester,
                                    onTap: () => {
                                      nav.goToSemesterPage(
                                        givenSemester: semester.givenSemester!,
                                        semesterGPA: semester.semesterGPA!,
                                        totalSKS: semester.totalSKS!,
                                      )
                                    },
                                  ),
                                )
                              else
                                CardSemester(
                                  model: semester,
                                  onTap: () => {
                                    nav.goToSemesterPage(
                                      givenSemester: semester.givenSemester!,
                                      semesterGPA: semester.semesterGPA!,
                                      totalSKS: semester.totalSKS!,
                                    )
                                  },
                                ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 16),
                      ),
                    ),
                  ],
                );
              },
            ),
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
    return true;
  }

  void onScroll() {}

  Future<void> retrieveData() async {
    await semesterRM.setState((s) => s.retrieveData());
    if (semesterRM.state.autoFillSemesters.isEmpty) {
      await semesterRM.setState((s) => s.retrieveDataForAutoFillSemesters());
    }
  }

  bool scrollCondition() {
    throw UnimplementedError();
  }

  Future<void> showAutoFillSemesterDialog(BuildContext context) async {
    final availableSemesters = semesterRM.state.availableSemestersToFill;
    await showDialog(
      context: context,
      // barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return AutoFillSemesterDialog(
          availableSemesters: availableSemesters,
        );
      },
    );
  }

  Future<void> showAddSemesterDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSemesterDialog(
          userGen: int.parse(profileRM.state.profile.generation!),
          semesters: semesterRM.state.semesters,
          onPressed: (selectedSemester) {
            nav.pop();
            semesterRM.setState(
              (s) => s.postSemester(selectedSemester),
            );
          },
        );
      },
    );
  }

  Widget _addSemesterButton(int givenSemester) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: [
          PrimaryButton(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            borderRadius: BorderRadius.circular(8),
            width: double.infinity,
            text: 'Tambah Semester',
            backgroundColor: BaseColors.purpleHearth,
            onPressed: () => {
              showAddSemesterDialog(context),
            },
          ),
          const HeightSpace(25),
          if (semesterRM.state.availableSemestersToFill.isNotEmpty)
            Showcase.withWidget(
              key: inAppTourKeys.autoFillGC,
              overlayColor: BaseColors.neutral100,
              overlayOpacity: 0.5,
              targetPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              targetBorderRadius: BorderRadius.circular(10),
              blurValue: 1,
              height: 0,
              width: MediaQuery.of(context).size.width,
              disposeOnTap: false,
              disableBarrierInteraction: true,
              disableMovingAnimation: true,
              onTargetClick: () {
                ShowCaseWidget.of(calculatorContext!).dismiss();
                showMockAutoFillSemesterDialog(context);
              },
              container: autoFillGCShowcase(calculatorContext!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientBorderButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    borderWidth: 2,
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: BaseColors.autoSystemColor,
                    ),
                    width: double.infinity,
                    borderRadius: 8,
                    text: 'Auto-Fill Semester',
                    textStyle: FontTheme.poppins14w700black(),
                    onPressed: () => {
                      print('Button Auto-Fill are Pressed!'),
                      showAutoFillSemesterDialog(context),
                    }, // To Be Implemented
                  ),
                  const HeightSpace(5),
                  Text(
                    '*Saat ini, fitur hanya bisa digunakan oleh '
                    'mahasiswa/i Fakultas Ilmu Komputer.',
                    style: FontTheme.poppins10w400black().copyWith(
                      color: BaseColors.gray1,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            )
          else
            Container()
        ],
      ),
    );
  }

  String _semesterPendekValueChanger(String semester, int userGen) {
    if (semester.contains('sp')) {
      final val = int.tryParse(semester.split('_').last) ?? userGen + 1;
      return ((val - userGen) * 2 + 0.5).toString();
    }
    return semester;
  }
}
