part of '_containers.dart';

Widget searchBarSPShowcase(BuildContext ctx) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      const HeightSpace(12),
      Image.asset(
        'assets/ruby/ruby_wink_wave.png',
        height: 120,
      ),
      const HeightSpace(12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () async {
              ShowCaseWidget.of(ctx).dismiss();
              navbarController(0);
              await showcaseNavbarMatkul();
            },
            splashColor: BaseColors.transparent,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.symmetric(horizontal: 7),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: BaseColors.white,
            ),
          ),
          const WidthSpace(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kamu dapat mencari matakuliah\n'
                'dan riwayat pencarian kamu disini!',
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
                    onTap: () {
                      ShowCaseWidget.of(ctx).dismiss();
                      print('User skip!');
                      // await Pref.saveBool('doneAppTour', value: true);
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
                    await Future.delayed(
                      const Duration(milliseconds: 200),
                      () {
                        ShowCaseWidget.of(ctx).next();
                      },
                    );
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

Widget filterSPShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const HeightSpace(50),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  ShowCaseWidget.of(ctx).previous();
                },
                splashColor: BaseColors.transparent,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: BaseColors.white,
                ),
              ),
              const WidthSpace(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kalau kamu butuh matkul sesuai\n'
                    'kriteria yang lebih advance, kamu\n'
                    'bisa melakukan filter disini.',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WidthSpace(21),
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
                        onTap: () {
                          ShowCaseWidget.of(ctx).dismiss();
                          print('User skip!');
                          // await Pref.saveBool('doneAppTour', value: true);
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
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      Positioned(
        left: 110,
        top: -80,
        child: Image.asset(
          'assets/ruby/ruby_right.png',
          height: 120,
        ),
      ),
    ],
  );
}

Widget cardCourseSPShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const HeightSpace(25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  ShowCaseWidget.of(ctx).previous();
                },
                splashColor: BaseColors.transparent,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: BaseColors.white,
                ),
              ),
              const WidthSpace(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kamu dapat melihat detail matakuliah\n'
                    'disini, lho!',
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
                        onTap: () {
                          ShowCaseWidget.of(ctx).dismiss();
                          print('User skip!');
                          // await Pref.saveBool('doneAppTour', value: true);
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
        left: MediaQuery.of(ctx).size.width * 0.5 - 75,
        top: -230,
        child: Image.asset(
          'assets/ruby/ruby_smile_wave.png',
          height: 120,
        ),
      ),
    ],
  );
}
