part of '_containers.dart';

Widget userBoxTTShowcase(BuildContext ctx) {
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
                  navbarController(1);
                  await showcaseNavbarTanyaTeman();
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
                    'Kamu dapat membuat pertanyaanmu\ndisini.',
                    style: FontTheme.poppins14w700black().copyWith(
                      fontSize: 13,
                      color: BaseColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                          backFromTanyaTeman = false;
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
                        backFromTanyaTeman = false;
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
        right: 0,
        top: -195,
        child: Image.asset(
          'assets/ruby/ruby_smile_wave.png',
          height: 120,
        ),
      ),
    ],
  );
}

Widget searchBarTTShowcase(BuildContext ctx) {
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
          const WidthSpace(175),
        ],
      ),
      const HeightSpace(15),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WidthSpace(12),
          IconButton(
            onPressed: () async {
              ShowCaseWidget.of(ctx).dismiss();
              backFromTanyaTeman = true;
              await showcaseTanyaTeman(previous: true);
            },
            splashColor: BaseColors.transparent,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.symmetric(horizontal: 7),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: BaseColors.white,
            ),
          ),
          const WidthSpace(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kamu juga dapat mencari pertanyaan\n'
                'berdasarkan matkul atau sub-string\n'
                'pada bar diatas.',
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
                    ShowCaseWidget.of(ctx).next();
                    await showcaseNavbarCalc();
                  },
                ),
                const WidthSpace(8),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
