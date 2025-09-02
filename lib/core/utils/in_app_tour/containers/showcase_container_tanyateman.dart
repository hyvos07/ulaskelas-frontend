part of '_containers.dart';

Widget userBoxTTShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        padding: const EdgeInsets.only(left: 12, right: 20),
        alignment: Alignment.center,
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
                    navbarController(1);
                    await showcaseNavbarTanyaTeman();
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
                  'Kamu dapat membuat pertanyaanmu disini.',
                  style: FontTheme.poppins14w700black().copyWith(
                    fontSize: 13,
                    color: BaseColors.white,
                  ),
                ),
              ],
            ),
            const HeightSpace(10),
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
      ),
      Positioned(
        right: 24,
        top: -200,
        child: Image.asset(
          'assets/ruby/ruby_smile_wave.png',
          height: 130,
        ),
      ),
    ],
  );
}

Widget searchBarTTShowcase(BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightSpace(12),
            Image.asset(
              'assets/ruby/ruby_wink_wave.png',
              height: 110,
            ),
            const HeightSpace(20),
            InkWell(
              onTap: () async {
                ShowCaseWidget.of(ctx).dismiss();
                backFromTanyaTeman = true;
                await showcaseTanyaTeman(previous: true);
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
    ),
  );
}
