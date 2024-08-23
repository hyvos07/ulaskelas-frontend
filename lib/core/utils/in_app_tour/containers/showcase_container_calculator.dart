part of '_containers.dart';

Widget emptyCalcGCShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () async {
                  ShowCaseWidget.of(ctx).dismiss();
                  navbarController(2);
                  await showcaseNavbarCalc();
                },
                splashColor: BaseColors.transparent,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: BaseColors.white,
                ),
              ),
              const WidthSpace(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kamu dapat menambah nilai kamu\n'
                    'per semester disini. Untuk mahasiswa\n'
                    'Fasilkom, kamu bisa mengisi secara\n'
                    'otomatis semester dan matkul kamu\n'
                    'lewat Auto-Fill Semester!',
                    style: FontTheme.poppins12w700black().copyWith(
                      fontSize: 13,
                      color: BaseColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const HeightSpace(7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          ShowCaseWidget.of(ctx).dismiss();
                          backFromCalculator = false;
                          print('User skip!');
                          await Pref.saveBool('doneAppTour', value: true);
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
          const HeightSpace(15),
        ],
      ),
      Positioned(
        left: -7,
        bottom: -50,
        child: Image.asset(
          'assets/ruby/ruby_smile_wave.png',
          height: 120,
        ),
      ),
    ],
  );
}

Widget autoFillGCShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const HeightSpace(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () async {
                  ShowCaseWidget.of(ctx).dismiss();
                  backFromCalculator = true;
                  await showcaseEmptySemester(previous: true);
                },
                splashColor: BaseColors.transparent,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: BaseColors.white,
                ),
              ),
              const WidthSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          text: 'autofill',
                          style: FontTheme.poppins12w700black().copyWith(
                            fontSize: 13,
                            color: BaseColors.malibu,
                          ),
                        ),
                        TextSpan(
                          text: '! Tenang\nsaja, kamu dapat mengubahnya nanti.',
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
                          ShowCaseWidget.of(ctx).dismiss();
                          print('User skip!');
                          await Pref.saveBool('doneAppTour', value: true);
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      Positioned(
        left: 0,
        top: -220,
        child: Image.asset(
          'assets/ruby/ruby_right.png',
          height: 120,
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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      const HeightSpace(10),
      Row(
        children: [
          Image.asset(
            'assets/ruby/ruby_wink_wave.png',
            height: 120,
          ),
          const WidthSpace(75),
        ],
      ),
      const HeightSpace(15),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WidthSpace(5),
          if (!userHasUsedAutoFill)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    navbarController(2);
                    await showcaseNavbarCalc();
                  },
                  splashColor: BaseColors.transparent,
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: BaseColors.white,
                  ),
                ),
              ],
            ),
          const WidthSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      ShowCaseWidget.of(ctx).dismiss();
                      print('User skip!');
                      backFromCalculator = false;
                      await Pref.saveBool('doneAppTour', value: true);
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
  );
}

Widget semesterCardGCShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const HeightSpace(45),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () async {
                  ShowCaseWidget.of(ctx).dismiss();
                  await showcaseFilledSemester(previous: true);
                },
                splashColor: BaseColors.transparent,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: BaseColors.white,
                ),
              ),
              const WidthSpace(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          text: '" untuk melihat detail\n'
                              'semester ini dan mata kuliah pada\n'
                              'semester tersebut.',
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
            ],
          ),
          const HeightSpace(7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          ShowCaseWidget.of(ctx).dismiss();
                          print('User skip!');
                          await Pref.saveBool('doneAppTour', value: true);
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
                    const WidthSpace(5),
                  ],
                ),
              ),
            ],
          ),
          const HeightSpace(15),
        ],
      ),
      Positioned(
        right: -15,
        top: -85,
        child: Image.asset(
          'assets/ruby/ruby_left.png',
          height: 120,
        ),
      ),
    ],
  );
}
