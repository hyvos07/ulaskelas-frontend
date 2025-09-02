part of '_containers.dart';

Widget navbarMatkulShowcase(
  String text,
  BuildContext ctx,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            ShowCaseWidget.of(ctx).dismiss();
            showInAppTourOpening(ctx, back: true);
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
          'Matkul',
          style: FontTheme.poppins14w700black().copyWith(
            color: BaseColors.malibu,
          ),
        ),
        const HeightSpace(6),
        Text(
          'Disini, kamu dapat melihat daftar mata kuliah\n'
          'yang ada di seluruh Universitas Indonesia lho!',
          style: FontTheme.poppins14w700black().copyWith(
            fontSize: 13,
            color: BaseColors.white,
          ),
        ),
        const HeightSpace(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/ruby/ruby_idle.png',
              height: 130,
            ),
            const WidthSpace(10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    width: 80,
                    child: InkWell(
                      onTap: () async {
                        await showSkipConfirmationDialog(ctx);
                      },
                      child: Text(
                        'Lewati',
                        style: FontTheme.poppins14w700black().copyWith(
                          color: BaseColors.gray4,
                        ),
                      ),
                    ),
                  ),
                  const WidthSpace(15),
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
    ),
  );
}

Widget navbarTanyaTemanShowcase(
  String text,
  BuildContext ctx,
) {
  return Container(
    width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    backFromTanyaTeman = false;
                    backToDetailPage();
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
                  'Tanya Teman',
                  style: FontTheme.poppins14w700black().copyWith(
                    color: BaseColors.malibu,
                  ),
                ),
                const HeightSpace(6),
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
                            await showSkipConfirmationDialog(ctx);
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
                          await Future.delayed(
                              const Duration(milliseconds: 200));
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
        const WidthSpace(12),
        Image.asset(
          'assets/ruby/ruby_left.png',
          height: 130,
        ),
      ],
    ),
  );
}

Widget navbarCalcShowcase(
  String text,
  BuildContext ctx,
) {
  return Container(
    width: MediaQuery.of(ctx).size.width, // minus padding listview
    padding: const EdgeInsets.only(left: 12, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    backFromCalculator = false;
                    await showcaseTanyaTeman(back: true);
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
                  'Grade Calculator!',
                  style: FontTheme.poppins14w700black().copyWith(
                    color: BaseColors.malibu,
                  ),
                ),
                const HeightSpace(6),
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
                            await showSkipConfirmationDialog(ctx);
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
                          await Future.delayed(
                              const Duration(milliseconds: 200));
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
        const WidthSpace(12),
        Image.asset(
          'assets/ruby/ruby_left.png',
          height: 130,
        ),
      ],
    ),
  );
}

Widget navbarProfileShowcase(
  String text,
  BuildContext ctx,
) {
  return Container(
    width: MediaQuery.of(ctx).size.width - 32, // minus padding listview
    padding: const EdgeInsets.only(right: 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                ShowCaseWidget.of(ctx).dismiss();
                if (secondComponentFilled) {
                  await mockComponentRM.setState((s) {
                    s
                      ..addComponent(1, 99999)
                      ..addComponent(2, 99999);
                    return true;
                  });
                }
                openSemesterPage();
                backToMatkulCalcPage();
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
        const HeightSpace(5),
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
        const HeightSpace(5),
        Image.asset(
          'assets/ruby/ruby_right.png',
          height: 135,
        ),
        const HeightSpace(10),
      ],
    ),
  );
}
