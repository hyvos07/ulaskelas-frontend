part of '_containers.dart';

Widget courseCardGCShowcase(
  BuildContext ctx,
  CalculatorModel calculator,
  String givenSemester,
) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        padding: const EdgeInsets.only(left: 12, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightSpace(20),
            InkWell(
              onTap: () async {
                ShowCaseWidget.of(ctx).dismiss();
                nav.pop();
                await showcaseFilledSemester(back: true);
              },
              splashColor: BaseColors.transparent,
              highlightColor: BaseColors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_back_rounded,
                      color: BaseColors.white,
                    ),
                    const WidthSpace(8),
                    Text(
                      'Kembali',
                      style: FontTheme.poppins14w700white(),
                    ),
                  ],
                ),
              ),
            ),
            const HeightSpace(8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Klik ',
                    style: FontTheme.poppins12w700black().copyWith(
                      fontSize: 13,
                      color: BaseColors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'Matkul',
                    style: FontTheme.poppins12w700black().copyWith(
                      fontSize: 13,
                      color: BaseColors.malibu,
                    ),
                  ),
                  TextSpan(
                    text: ' untuk melihat detail mata kuliah.',
                    style: FontTheme.poppins12w700black().copyWith(
                      fontSize: 13,
                      color: BaseColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const HeightSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        width: 90,
                        child: InkWell(
                          onTap: () async {
                            await showSkipConfirmationDialog(ctx);
                          },
                          child: Text(
                            'Lewati',
                            style: FontTheme.poppins14w700black().copyWith(
                              color: BaseColors.gray4,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      const WidthSpace(25),
                      PrimaryButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        width: 90,
                        borderRadius: BorderRadius.circular(8),
                        backgroundColor: BaseColors.white,
                        child: Text(
                          'Next',
                          style: FontTheme.poppins14w700black().copyWith(
                            color: BaseColors.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () async {
                          ShowCaseWidget.of(ctx).dismiss();
                          backFromNavbarProfile = false;
                          backToMatkulCalcPage = () => nav.push<void>(
                                MockCalculatorComponentPage(
                                  givenSemester: givenSemester,
                                  courseId: calculator.courseId!,
                                  calculatorId: calculator.id!,
                                  courseName: calculator.courseName!,
                                  totalScore: calculator.totalScore!,
                                  totalPercentage: calculator.totalPercentage!,
                                  courseSKS: calculator.courseSKS!,
                                ),
                                RouteName.calculatorComponent,
                              );
                          backToMatkulCalcPage();
                          await mockComponentRM.setState(
                            (s) => s.components.clear(),
                          );
                        },
                      ),
                      const WidthSpace(5),
                    ],
                  ),
                ),
              ],
            ),
            const HeightSpace(15),
          ],
        ),
      ),
      Positioned(
        left: 0,
        top: -200,
        child: Image.asset(
          'assets/ruby/ruby_click.png',
          height: 130,
        ),
      ),
    ],
  );
}
