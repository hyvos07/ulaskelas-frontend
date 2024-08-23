part of '_containers.dart';

Widget navbarMatkulShowcase(
  String text,
  BuildContext ctx,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              ShowCaseWidget.of(ctx).dismiss();
              showInAppTourOpening(ctx, back: true);
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
              Text(
                '$text!',
                style: FontTheme.poppins14w700black().copyWith(
                  color: BaseColors.malibu,
                ),
              ),
              const HeightSpace(15),
              Text(
                'Disini, kamu dapat melihat daftar mata\n'
                'kuliah yang ada di seluruh Universitas\n'
                'Indonesia lho!',
                style: FontTheme.poppins14w700black().copyWith(
                  fontSize: 13,
                  color: BaseColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
      const HeightSpace(5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/ruby/ruby_idle.png',
            height: 125,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: 75,
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
                    navbarController(1);
                    await Future.delayed(const Duration(milliseconds: 200));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      const HeightSpace(5),
    ],
  );
}

Widget navbarTanyaTemanShowcase(
  String text,
  BuildContext ctx,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
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
                  backFromTanyaTeman = false;
                  backToDetailPage();
                },
                splashColor: BaseColors.transparent,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: BaseColors.white,
                ),
              ),
              const WidthSpace(7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: FontTheme.poppins14w700black().copyWith(
                      color: BaseColors.malibu,
                    ),
                  ),
                  const HeightSpace(15),
                  Text(
                    'Disini adalah tempat berdiskusi\n'
                    'untuk kamu dan teman-teman\n'
                    'mahasiswa lainnya!',
                    style: FontTheme.poppins14w700black().copyWith(
                      fontSize: 13,
                      color: BaseColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const HeightSpace(5),
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
                      width: 75,
                      child: InkWell(
                        onTap: () async {
                          ShowCaseWidget.of(ctx).dismiss();
                          backFromTanyaTeman = false;
                          print('User skip!');
                          await Pref.saveBool('doneAppTour', value: true);
                        },
                        child: Text(
                          'Lewati',
                          style: FontTheme.poppins14w700black().copyWith(
                            color: BaseColors.gray4,
                          ),
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
                        navbarController(2);
                        backFromTanyaTeman = true;
                        await Future.delayed(const Duration(milliseconds: 200));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const HeightSpace(5),
        ],
      ),
      const WidthSpace(5),
      Image.asset(
        'assets/ruby/ruby_left.png',
        height: 125,
      ),
    ],
  );
}

Widget navbarCalcShowcase(
  String text,
  BuildContext ctx,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const WidthSpace(15),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () async {
                  ShowCaseWidget.of(ctx).dismiss();
                  backFromCalculator = false;
                  await showcaseTanyaTeman(back: true);
                },
                splashColor: BaseColors.transparent,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: BaseColors.white,
                ),
              ),
              const WidthSpace(7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Grade Calculator!',
                    style: FontTheme.poppins14w700black().copyWith(
                      color: BaseColors.malibu,
                    ),
                  ),
                  const HeightSpace(12),
                  Text(
                    'Disini adalah tempat berdiskusi\n'
                    'untuk kamu dan teman-teman\n'
                    'mahasiswa lainnya!',
                    style: FontTheme.poppins14w700black().copyWith(
                      fontSize: 13,
                      color: BaseColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const HeightSpace(5),
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
                      width: 75,
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
                        backFromCalculator = true;
                        navbarController(3);
                        await Future.delayed(const Duration(milliseconds: 200));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const HeightSpace(5),
        ],
      ),
      const WidthSpace(5),
      Image.asset(
        'assets/ruby/ruby_left.png',
        height: 125,
      ),
    ],
  );
}

Widget navbarProfileShowcase(
  String text,
  BuildContext ctx,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const WidthSpace(25),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () async {
                  ShowCaseWidget.of(ctx).dismiss();
                  backToMatkulCalcPage();
                  // await showcaseComponentPage(back: true);
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
                  Text(
                    'Profil',
                    style: FontTheme.poppins14w700black().copyWith(
                      color: BaseColors.malibu,
                    ),
                  ),
                  const HeightSpace(12),
                  Text(
                    'Disini adalah tempat untuk melihat\nprofile kamu.',
                    style: FontTheme.poppins14w700black().copyWith(
                      fontSize: 13,
                      color: BaseColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const HeightSpace(5),
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
                      width: 75,
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
                        navbarController(4);
                        await Future.delayed(
                            const Duration(milliseconds: 200), () {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const HeightSpace(5),
          Image.asset(
            'assets/ruby/ruby_right.png',
            height: 145,
          ),
          const HeightSpace(10),
        ],
      ),
    ],
  );
}
