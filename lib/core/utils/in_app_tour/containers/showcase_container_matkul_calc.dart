part of '_containers.dart';

Widget totalComponentGCShowcase(BuildContext ctx) {
  return Container(
    width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
    padding: const EdgeInsets.only(left: 12, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const HeightSpace(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/ruby/ruby_smile.png',
              height: 120,
            ),
            const HeightSpace(8),
            InkWell(
              onTap: () async {
                ShowCaseWidget.of(ctx).dismiss();
                nav.pop();
                await showcaseSemesterPage(back: true);
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
            const HeightSpace(7),
            Text(
              'Di sini kamu bisa cek nilai akhir kamu, '
              'tapi isi dulu bobot komponen sampai 100% '
              'biar kita bisa kasih rekomendasi.',
              style: FontTheme.poppins14w700black().copyWith(
                fontSize: 13,
                color: BaseColors.white,
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
                width: 75,
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
  );
}

Widget addComponentGCShowcase(BuildContext ctx, VoidCallback goTo) {
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
                if (!backFromAddComponent) {
                  ShowCaseWidget.of(ctx).previous();
                } else {
                  ShowCaseWidget.of(ctx).dismiss();
                  await showcaseComponentPage();
                  backFromAddComponent = false;
                }
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
                    text: '"Tambah Komponen"',
                    style: FontTheme.poppins12w700black().copyWith(
                      fontSize: 13,
                      color: BaseColors.malibu,
                    ),
                  ),
                  TextSpan(
                    text: ' untuk menambahkan komponen penilaian dan bobotnya!',
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
                        onPressed: () {
                          ShowCaseWidget.of(ctx).dismiss();
                          goTo();
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
        top: -185,
        child: Image.asset(
          'assets/ruby/ruby_click.png',
          height: 130,
        ),
      ),
    ],
  );
}

Widget incompleteComponentGCShowcase(BuildContext ctx, VoidCallback goTo) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        padding: const EdgeInsets.only(left: 12, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightSpace(12),
            InkWell(
              onTap: () async {
                ShowCaseWidget.of(ctx).dismiss();
                goTo();
                await mockComponentRM.state.deleteComponent(1);
                await showcaseAddComponentScore();
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
              'Komponen UTS berhasil ditambahkan! Sekarang lengkapi komponen '
              'lainnya hingga total bobotnya 100%.',
              style: FontTheme.poppins14w700black().copyWith(
                fontSize: 13,
                color: BaseColors.white,
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
                        onPressed: () {
                          ShowCaseWidget.of(ctx).dismiss();
                          goTo();
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
        right: 0,
        top: -405,
        child: Image.asset(
          'assets/ruby/ruby_smile.png',
          height: 125,
        ),
      ),
    ],
  );
}

Widget targetScoreShowcase(BuildContext ctx, VoidCallback goTo) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const HeightSpace(32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    goTo();
                    await mockComponentRM.state.deleteComponent(2);
                    await showcaseAddComponentScore();
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
                const HeightSpace(10),
                Text(
                  'Sekarang, kamu sudah bisa memilih\n'
                  'target grade untuk mata kuliah ini.\n'
                  'Ubah sesuai keinginan lewat dropdown.',
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
                          ShowCaseWidget.of(ctx).dismiss();
                          await showcaseFinalScoreComponent();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        left: 120,
        top: -120,
        child: Image.asset(
          'assets/ruby/ruby_right.png',
          height: 135,
        ),
      ),
    ],
  );
}

Widget finalScoreGCShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        padding: const EdgeInsets.only(left: 12, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightSpace(24),
            InkWell(
              onTap: () async {
                ShowCaseWidget.of(ctx).dismiss();
                await showcaseTargetScoreComponent();
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
              'Wow, untuk mendapatkan grade A di mata kuliah ini, '
              'kamu perlu nilai UAS 100!',
              style: FontTheme.poppins14w700black().copyWith(
                fontSize: 13,
                color: BaseColors.white,
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
                          backFromNavbarProfile = true;
                          nav
                            ..pop()
                            ..pop();
                          await showcaseNavbarProfile();
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
        right: 8,
        top: -325,
        child: Image.asset(
          'assets/ruby/ruby_smile.png',
          height: 125,
        ),
      ),
    ],
  );
}
