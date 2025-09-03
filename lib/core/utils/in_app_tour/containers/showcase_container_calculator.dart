part of '_containers.dart';

Widget emptyCalcGCShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        padding: const EdgeInsets.only(left: 12, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const HeightSpace(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    navbarController(2);
                    await showcaseNavbarCalc();
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
                Text(
                  'Kamu dapat melakukan tambah semester dan untuk '
                  'mahasiswa Fasilkom, kamu juga dapat melakukan Auto-Fill '
                  'Semester ',
                  style: FontTheme.poppins12w700black().copyWith(
                    fontSize: 13,
                    color: BaseColors.white,
                  ),
                ),
              ],
            ),
            const HeightSpace(7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                            textAlign: TextAlign.center,
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
                          ShowCaseWidget.of(ctx).next();
                          backFromCalculator = false;
                        },
                      ),
                      const WidthSpace(8),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        left: 10,
        top: semesterRM.state.semesters.isEmpty ? -400 : -310,
        child: Image.asset(
          'assets/ruby/ruby_smile_wave.png',
          height: 135,
        ),
      ),
    ],
  );
}

Widget autoFillGCShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 32, // minus padding listview
        padding: const EdgeInsets.only(left: 12, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const HeightSpace(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    backFromCalculator = true;
                    await showcaseEmptySemester(previous: true);
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
                        text: 'Untuk sekarang pilihlah ',
                        style: FontTheme.poppins12w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Auto-Fill Semester',
                        style: FontTheme.poppins12w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.malibu,
                        ),
                      ),
                      TextSpan(
                        text: ', tenang saja, kamu dapat mengubahnya nanti',
                        style: FontTheme.poppins12w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const HeightSpace(7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WidthSpace(21),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
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
                      const WidthSpace(32),
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
                          ShowCaseWidget.of(calculatorContext!).dismiss();
                          await showMockAutoFillSemesterDialog(ctx);
                        },
                      ),
                      const WidthSpace(8),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        left: 10,
        top: -215,
        child: Image.asset(
          'assets/ruby/ruby_right.png',
          height: 130,
        ),
      ),
    ],
  );
}

Future<void> showMockAutoFillSemesterDialog(BuildContext ctx) async {
  await showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (context) {
      return MockAutoFillDialog(ctx: ctx);
    },
  );
}

Widget filledCalcGCShowcase(BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const HeightSpace(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/ruby/ruby_smile.png',
              height: 125,
            ),
            InkWell(
              onTap: () {
                ShowCaseWidget.of(calculatorContext!).dismiss();
                showMockAutoFillSemesterDialog(ctx);
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
            Text(
              'Disini lah data semester dan nilai yang\n'
              'kamu punya disimpan!',
              style: FontTheme.poppins14w700black().copyWith(
                fontSize: 13,
                color: BaseColors.white,
              ),
            ),
          ],
        ),
        const HeightSpace(7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
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
                        textAlign: TextAlign.center,
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
                      ShowCaseWidget.of(ctx).next();
                      backFromCalculator = false;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget semesterCardGCShowcase(BuildContext ctx, SemesterModel semester) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        padding: const EdgeInsets.only(left: 12, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const HeightSpace(65),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    backFromCalculator = true;
                    await showcaseFilledSemester(previous: true);
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
                        text: 'Klik "',
                        style: FontTheme.poppins12w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'semester',
                        style: FontTheme.poppins12w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.malibu,
                        ),
                      ),
                      TextSpan(
                        text: '" untuk melihat detail semester dan '
                            'mata kuliah pada semester tersebut.',
                        style: FontTheme.poppins12w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const HeightSpace(7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                          await nav.goToSemesterPage(
                            givenSemester: semester.givenSemester!,
                            semesterGPA: semester.semesterGPA!,
                            totalSKS: semester.totalSKS!,
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
        right: 10,
        top: -65,
        child: Image.asset(
          'assets/ruby/ruby_click_2.png',
          height: 130,
        ),
      ),
    ],
  );
}
