part of '_containers.dart';

Widget finalScoreGCShowcase(BuildContext ctx) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      const HeightSpace(10),
      Row(
        children: [
          Image.asset(
            'assets/ruby/ruby_wave_normal.png',
            height: 120,
          ),
        ],
      ),
      const HeightSpace(65),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () async {
              ShowCaseWidget.of(ctx).dismiss();
              nav.pop();
              await nav.goToSemesterPage(
                givenSemester: targetSemester['givenSemester'],
                semesterGPA: targetSemester['semesterGPA'],
                totalSKS: targetSemester['totalSKS'],
              );
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
                'Di bagian ini, kamu dapat melakukan\n'
                'perhitungan untuk memperkirakan nilai\n'
                'akhir yang kamu inginkan!',
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
        crossAxisAlignment: CrossAxisAlignment.end,
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

Widget totalComponentGCShowcase(BuildContext ctx) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () async {
              ShowCaseWidget.of(ctx).dismiss();
              backFromNavbarProfile = false;
              await showcaseComponentPage(previous: true);
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
                'Isilah 100% komponen lalu Ruby akan\n'
                'memberikan nilai yang harus kamu\n'
                'dapatkan untuk mencapai target!',
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
          Image.asset(
            'assets/ruby/ruby_wink_wave_tilted.png',
            height: 120,
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
                    backFromNavbarProfile = true;
                    nav.pop();
                    await showcaseNavbarProfile();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      const HeightSpace(10),
    ],
  );
}
