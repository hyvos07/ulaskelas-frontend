part of '_containers.dart';

Widget searchBarSPShowcase(BuildContext ctx) {
  return Container(
    width: MediaQuery.of(ctx).size.width - 28, // minus padding listview
    padding: const EdgeInsets.only(left: 12, right: 20),
    alignment: Alignment.centerRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const HeightSpace(16),
        Image.asset(
          'assets/ruby/ruby_wink_wave.png',
          height: 110,
        ),
        // const HeightSpace(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                ShowCaseWidget.of(ctx).dismiss();
                navbarController(0);
                await showcaseNavbarMatkul();
              },
              splashColor: BaseColors.transparent,
              highlightColor: BaseColors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
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
            const HeightSpace(10),
            Text(
              'Kamu dapat mencari matakuliah\n'
              'dan riwayat pencarian kamu\ndisini!',
              style: FontTheme.poppins14w700black().copyWith(
                fontSize: 13,
                color: BaseColors.white,
              ),
            ),
          ],
        ),
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
    ),
  );
}

Widget filterSPShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const HeightSpace(24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  ShowCaseWidget.of(ctx).previous();
                },
                splashColor: BaseColors.transparent,
                highlightColor: BaseColors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
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
              const HeightSpace(10),
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
        top: -100,
        child: Image.asset(
          'assets/ruby/ruby_right.png',
          height: 135,
        ),
      ),
    ],
  );
}

Widget cardCourseSPShowcase(BuildContext ctx, CourseModel course) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const HeightSpace(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    ShowCaseWidget.of(ctx).previous();
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
                          style: FontTheme.poppins14w700black().copyWith(
                            fontSize: 13,
                            color: BaseColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const HeightSpace(10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Klik mata kuliah ',
                        style: FontTheme.poppins14w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Basis Data',
                        style: FontTheme.poppins14w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.malibu,
                        ),
                      ),
                      TextSpan(
                        text: '\nuntuk melihat detail mata kuliah\ntersebut!',
                        style: FontTheme.poppins14w700black().copyWith(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                    onPressed: () {
                      ShowCaseWidget.of(ctx).dismiss();
                      nav.goToDetailMatkulPage(
                        course.id!,
                        course.code!,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 0,
        top: -205,
        child: Image.asset(
          'assets/ruby/ruby_click.png',
          height: 130,
        ),
      ),
    ],
  );
}
