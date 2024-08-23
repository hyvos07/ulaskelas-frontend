part of '_containers.dart';

Widget courseCardGCShowcase(BuildContext ctx) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const HeightSpace(40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () async {
                  ShowCaseWidget.of(ctx).dismiss();
                  nav.pop();
                  await showcaseFilledSemester(back: true);
                },
                splashColor: BaseColors.transparent,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: BaseColors.white,
                ),
              ),
              const WidthSpace(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          text: 'Matkul',
                          style: FontTheme.poppins12w700black().copyWith(
                            fontSize: 13,
                            color: BaseColors.malibu,
                          ),
                        ),
                        TextSpan(
                          text: ' untuk melihat detail mata\nkuliah.',
                          style: FontTheme.poppins12w700black().copyWith(
                            fontSize: 13,
                            color: BaseColors.white,
                          ),
                        ),
                      ],
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
                          textAlign: TextAlign.end,
                        ),
                      ),
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
      Positioned(
        right: -15,
        top: -90,
        child: Image.asset(
          'assets/ruby/ruby_left.png',
          height: 120,
        ),
      ),
    ],
  );
}
