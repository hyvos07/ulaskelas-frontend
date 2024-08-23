part of '_containers.dart';

Widget detailCourseDMShowCase(
  BuildContext ctx,
  ScrollController controller,
  Function(bool value) isScrollable,
) {
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
                onPressed: () async {
                  ShowCaseWidget.of(ctx).dismiss();
                  nav.pop();
                  await showcaseSearchPage();
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
                    'Disini terdapat overview general dan\n'
                    'prasyarat sebuah matkul.',
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
                            width: 90,
                            child: InkWell(
                              onTap: () async {
                                ShowCaseWidget.of(ctx).dismiss();
                                isScrollable(true);
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
      Positioned(
        right: -10,
        top: -105,
        child: Image.asset(
          'assets/ruby/ruby_left.png',
          height: 145,
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
                    'Scroll kebawah sedikit dan kamu bisa\n'
                    'berbagi pengalaman kamu mengenai\n'
                    'matkul tersebut!',
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
                            width: 90,
                            child: InkWell(
                              onTap: () async {
                                ShowCaseWidget.of(ctx).dismiss();
                                isScrollable(true);
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
                              isScrollable(false);
                              await controller.animateTo(
                                460,
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
      Positioned(
        right: -12,
        top: -305,
        child: Image.asset(
          'assets/ruby/ruby_smile.png',
          height: 130,
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const HeightSpace(60),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () async {
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
                    'Tentunya kamu bisa melihat rating\n'
                    'matkul dan ulasan orang lain terhadap\n'
                    'matkul tersebut!',
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
                            width: 90,
                            child: InkWell(
                              onTap: () async {
                                ShowCaseWidget.of(ctx).dismiss();
                                isScrollable(true);
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
      Positioned(
        right: -12,
        top: -65,
        child: Image.asset(
          'assets/ruby/ruby_wink_wave.png',
          height: 120,
        ),
      ),
    ],
  );
}
