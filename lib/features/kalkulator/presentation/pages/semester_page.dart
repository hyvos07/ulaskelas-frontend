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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          RefreshIndicator(
            onRefresh: retrieveData,
            key: refreshIndicatorKey,
            child: OnBuilder<CalculatorState>.all(
              listenTo: calculatorRM,
              onIdle: () => const CircleLoading(),
              onWaiting: () => const CircleLoading(),
              onError: (dynamic error, refresh) => Text(error.toString()),
              onData: (data) {
                final calculators = data.calculators;
                if (calculators.isEmpty) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          semesterName,
                          style: FontTheme.poppins14w700black(),
                        ),
                        Text(
                          widget.semesterGPA!.toStringAsFixed(2),
                          style: FontTheme.poppins14w700black(),
                        ),
                      ],
                    ),
                    const HeightSpace(28),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: calculators.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final calculator = calculators[index];
                        return Column(
                          children: [
                            CardCalculator(
                              model: calculator,
                              onTap: () => nav.goToComponentCalculatorPage(
                                calculatorId: calculator.id!,
                                courseName: calculator.courseName!,
                                totalScore: calculator.totalScore!,
                                totalPercentage: calculator.totalPercentage!,
                              ),
                            ),
                            const HeightSpace(35),
                            _addButton(),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
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
    return true;
  }

  Future<void> retrieveData() async {
    await calculatorRM.setState(
      (s) => s.retrieveData(),
    );
  }

  Widget _addButton() {
    return Column(
      children: [
        SecondaryButton(
          width: double.infinity,
          text: 'Tambah Mata Kuliah',
          backgroundColor: BaseColors.purpleHearth,
          onPressed: () => nav.goToSearchCourseCalculatorPage(),
        ),
        const HeightSpace(25),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                nav.pop();
                semesterRM.setState(
                  (s) => s.deleteSemester(
                    query: QuerySemester(
                      givenSemester: widget.givenSemester,
                    ),
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
      ],
    );
  }
}
