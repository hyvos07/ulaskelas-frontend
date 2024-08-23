part of '_widgets.dart';

class MockAutoFillDialog extends StatefulWidget {
  const MockAutoFillDialog({
    required this.ctx,
    super.key,
  });

  final BuildContext? ctx;

  @override
  State<MockAutoFillDialog> createState() => _MockAutoFillDialogState();
}

class _MockAutoFillDialogState extends State<MockAutoFillDialog> {
  final selectedSemesterList = ['1', '2'];
  final availableSemester = semesterRM.state.availableSemestersToFill;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          insetPadding: const EdgeInsets.fromLTRB(30, 50, 30, 275),
          titlePadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          contentPadding: const EdgeInsets.only(
            top: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
          elevation: 5,
          title: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Auto-fill Semester',
                        style: FontTheme.poppins16w700black(),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -15,
                    top: -5,
                    child: IconButton(
                      onPressed: () => nav.pop(),
                      icon: Icon(
                        Icons.close_rounded,
                        size: 30,
                        color: BaseColors.gray2,
                        shadows: List.generate(10, (index) {
                          return const Shadow(
                            color: BaseColors.gray2,
                            blurRadius: 1.5,
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rekomendasi Mata kuliah untuk jurusan kamu!',
                      style: FontTheme.poppins12w400black(),
                    ),
                    const HeightSpace(5),
                    Text(
                      '*Only available for Faculty of Computer Science for now.',
                      style: FontTheme.poppins6w400black().copyWith(
                        color: BaseColors.mineShaft.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        availableSemester.length,
                        (index) {
                          final semester = availableSemester[index];
                          return ExpansionCard(
                            title: 'Semester ${semester.givenSemester}',
                            forShowcase: index < 2,
                            children: semester.courseList,
                            onCheckboxChanged: (isChecked) {
                              setState(
                                () {
                                  if (isChecked) {
                                    selectedSemesterList
                                        .add(semester.givenSemester!);
                                  } else {
                                    selectedSemesterList
                                        .remove(semester.givenSemester);
                                  }
                                  print(selectedSemesterList);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SimpanButton(
                isForAutoFill: true,
                onTap: () {
                  selectedSemesterList
                      .sort((a, b) => int.parse(a).compareTo(int.parse(b)));
                  final model = <String, dynamic>{
                    'given_semesters': selectedSemesterList,
                  };
                  semesterRM.state.postAutoFillSemester(model);
                  userHasUsedAutoFill = true;
                  nav.pop();
                },
                text: 'Tambah Semester',
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 275 - (160 + 60),
          left: 30,
          child: Material(
            color: BaseColors.transparent,
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width - (30 * 2),
              decoration: const BoxDecoration(
                color: BaseColors.transparent,
              ),
              child: _buildContainer(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContainer() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () async {
                    nav.pop();
                    await showcaseEmptySemester(back: true);
                  },
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
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Disini, mata kuliah tiap semester\n'
                                'yang dipilih akan secara otomatis\n'
                                'ditambahkan secara default.\nCoba klik ',
                            style: FontTheme.poppins12w700black().copyWith(
                              fontSize: 13,
                              color: BaseColors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'Tambah Semester!',
                            style: FontTheme.poppins12w700black().copyWith(
                              fontSize: 13,
                              color: BaseColors.malibu,
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
                            nav.pop();
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          right: -15,
          top: -120,
          child: Image.asset(
            'assets/ruby/ruby_smile_wave.png',
            height: 120,
          ),
        ),
      ],
    );
  }
}
