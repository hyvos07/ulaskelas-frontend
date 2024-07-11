part of '_pages.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({
    super.key,
  });

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends BaseStateful<CalculatorPage> {
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
                        width: sizeInfo.screenSize.width * .6,
                      ),
                      const HeightSpace(20),
                      Text(
                        'Belum Ada Nilai yang Tersimpan',
                        style: FontTheme.poppins14w700black().copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const HeightSpace(10),
                      Text(
                        'Kamu belum memiliki nilai semester.\n'
                        'Silakan tambahkan terlebih dahulu.',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const HeightSpace(35),
                      SecondaryButton(
                        width: double.infinity,
                        text: 'Tambah Semester',
                        backgroundColor: BaseColors.purpleHearth,
                        onPressed: () => {
                          semesterRM.setState(
                            (s) => s.postSemester(
                              <String, num>{
                                'given_semester': 1,
                                'semester_gpa': 3.89,
                                'total_sks': 18,
                              },
                            ),
                          )
                        },
                      ),
                      const HeightSpace(25),
                      PrimaryButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 24,
                        ),
                        width: double.infinity,
                        text: 'Auto-Fill Semester',
                        backgroundColor: BaseColors.purpleHearth,
                        onPressed: () => {
                          print('Button Auto-Fill are Pressed!')
                        }, // To Be Implemented
                      )
                    ],
                  ),
                ),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'IPK',
                        style: FontTheme.poppins16w400black(),
                      ),
                      Text(
                        semesterRM.state.gpa,
                        style: FontTheme.poppins16w700black(),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: semesterRM.state.semesters.length + 1,
                    itemBuilder: (context, index) {
                      if (index == semesters.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: Column(
                            children: [
                              SecondaryButton(
                                width: double.infinity,
                                text: 'Tambah Semester',
                                backgroundColor: BaseColors.purpleHearth,
                                onPressed: () => {
                                  semesterRM.setState(
                                    (s) => s.postSemester(
                                      <String, dynamic>{
                                        'given_semester': index + 1,
                                        'semester_gpa': 3.89,
                                        'total_sks': 18,
                                      },
                                    ),
                                  )
                                },
                              ),
                              const HeightSpace(25),
                              PrimaryButton(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 24,
                                ),
                                width: double.infinity,
                                text: 'Auto-Fill Semester',
                                backgroundColor: BaseColors.purpleHearth,
                                onPressed: () => {
                                  print('Button Auto-Fill are Pressed!')
                                }, // To Be Implemented
                              )
                            ],
                          ),
                        );
                      }
                      final semester = semesters[index];
                      return Column(
                        children: [
                          // CardCalculator(
                          //   model: calculator,
                          //   onTap: () => nav.goToComponentCalculatorPage(
                          //     calculatorId: calculator.id!,
                          //     courseName: calculator.courseName!,
                          //     totalScore: calculator.totalScore!,
                          //     totalPercentage: calculator.totalPercentage!,
                          //   ),
                          // ),
                          // const HeightSpace(10),
                          CardSemester(
                            model: semester,
                            onTap: () => {
                              semesterRM.setState(
                                (s) => s.deleteSemester(
                                  query: QuerySemester(
                                    givenSemester: semester.givenSemester,
                                  ),
                                ),
                              )
                            },
                            // nav.goToComponentCalculatorPage(
                            //   calculatorId: calculator.id!,
                            //   courseName: calculator.courseName!,
                            //   totalScore: calculator.totalScore!,
                            //   totalPercentage: calculator.totalPercentage!,
                            // ),
                          )
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
  }

  bool scrollCondition() {
    throw UnimplementedError();
  }
}
