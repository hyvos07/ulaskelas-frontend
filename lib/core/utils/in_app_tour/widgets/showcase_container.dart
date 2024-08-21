// This will store the container of each step in the in-app tour

part of '_widgets.dart';

Widget navbarMatkulShowcase(
  String text,
  Function(int index) navigate,
  BuildContext ctx,
) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
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
                    navigate(1);
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
  Function(int index) navigate,
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
                onPressed: () {
                  //TODO
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
                    'mahasiswa lainnya.',
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
                        navigate(2);
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

Widget searchBarSPShowcase(BuildContext ctx) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      const HeightSpace(20),
      Image.asset(
        'assets/ruby/ruby_wink_wave.png',
        height: 120,
      ),
      const HeightSpace(20),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              ShowCaseWidget.of(ctx).dismiss(); //TODO
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
          const HeightSpace(55),
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
          const HeightSpace(55),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  ShowCaseWidget.of(ctx).previous(); //TODO
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
                              onTap: () {
                                ShowCaseWidget.of(ctx).dismiss();
                                isScrollable(true);
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
        right: -12,
        top: -100,
        child: Image.asset(
          'assets/ruby/ruby_left.png',
          height: 150,
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
                  await showcaseCourseDetail();
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
                              onTap: () {
                                ShowCaseWidget.of(ctx).dismiss();
                                isScrollable(true);
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
                              isScrollable(false);
                              await controller.animateTo(
                                525,
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
        top: -300,
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
) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const HeightSpace(65),
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
                              onTap: () {
                                ShowCaseWidget.of(ctx).dismiss();
                                isScrollable(true);
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
                              isScrollable(true);
                              nav.pop();
                              await Future.delayed(
                                const Duration(milliseconds: 200),
                                showcaseNavbarTanyaTeman,
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
