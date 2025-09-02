part of '_containers.dart';

Widget detailCourseDMShowCase(
  BuildContext ctx,
  ScrollController controller,
  Function(bool value) isScrollable,
) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        padding: const EdgeInsets.only(left: 12, right: 20),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightSpace(24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    nav.pop();
                    await showcaseSearchPage();
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
                  'Disini terdapat overview general dan\n'
                  'prasyarat sebuah matkul.',
                  style: FontTheme.poppins14w700black().copyWith(
                    fontSize: 13,
                    color: BaseColors.white,
                  ),
                ),
              ],
            ),
            const HeightSpace(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const WidthSpace(21),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
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
                              width: 100,
                              child: InkWell(
                                onTap: () async {
                                  await showSkipConfirmationDialog(ctx);
                                },
                                child: Text(
                                  'Lewati',
                                  style:
                                      FontTheme.poppins14w700black().copyWith(
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
                                isScrollable(false);
                                await controller.animateTo(
                                  175,
                                  duration: const Duration(milliseconds: 1500),
                                  curve: Curves.fastOutSlowIn,
                                );
                                isScrollable(true);
                                await showcaseReviewing();
                              },
                            ),
                          ],
                        ),
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
        right: 10,
        top: -105,
        child: Image.asset(
          'assets/ruby/ruby_left.png',
          height: 135,
        ),
      ),
    ],
  );
}

Widget reviewByYouDMShowcase(
  BuildContext ctx,
  ScrollController controller,
  Function(bool value) isScrollable,
) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        padding: const EdgeInsets.only(left: 12, right: 20),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const HeightSpace(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    isScrollable(false);
                    await controller.animateTo(
                      0,
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastOutSlowIn,
                    );
                    isScrollable(true);
                    await showcaseCourseDetail(back: true);
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
                const HeightSpace(8),
                Text(
                  'Scroll kebawah sedikit dan kamu bisa berbagi '
                  'pengalaman kamu mengenai matkul tersebut!',
                  style: FontTheme.poppins14w700black().copyWith(
                    fontSize: 13,
                    color: BaseColors.white,
                  ),
                ),
              ],
            ),
            const HeightSpace(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
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
                              width: 100,
                              child: InkWell(
                                onTap: () async {
                                  await showSkipConfirmationDialog(ctx);
                                },
                                child: Text(
                                  'Lewati',
                                  style:
                                      FontTheme.poppins14w700black().copyWith(
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
                                isScrollable(false);
                                await controller.animateTo(
                                  400,
                                  duration: const Duration(milliseconds: 1500),
                                  curve: Curves.fastOutSlowIn,
                                );
                                isScrollable(true);
                                await showcaseReviews();
                              },
                            ),
                          ],
                        ),
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
        right: 16,
        top: -250,
        child: Image.asset(
          'assets/ruby/ruby_smile.png',
          height: 125,
        ),
      ),
    ],
  );
}

Widget reviewsDMShowcase(
  BuildContext ctx,
  ScrollController controller,
  Function(bool value) isScrollable,
  VoidCallback onBackToHere,
) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width - 24, // minus padding listview
        padding: const EdgeInsets.only(left: 12, right: 20),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const HeightSpace(42),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    isScrollable(false);
                    await controller.animateTo(
                      175,
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastOutSlowIn,
                    );
                    isScrollable(true);
                    await showcaseReviewing();
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
                  'Tentunya kamu bisa melihat rating matkul dan '
                  'ulasan orang lain terhadap matkul tersebut!',
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
                const WidthSpace(21),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
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
                              width: 100,
                              child: InkWell(
                                onTap: () async {
                                  await showSkipConfirmationDialog(ctx);
                                },
                                child: Text(
                                  'Lewati',
                                  style:
                                      FontTheme.poppins14w700black().copyWith(
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
                                isScrollable(true);
                                nav.pop();
                                await Future.delayed(
                                  const Duration(milliseconds: 400),
                                  () => showcaseNavbarTanyaTeman(
                                    onBack: onBackToHere,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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
        right: 12,
        top: -65,
        child: Image.asset(
          'assets/ruby/ruby_wink_wave.png',
          height: 110,
        ),
      ),
    ],
  );
}
