part of '_containers.dart';

Widget componentFieldShowcase(BuildContext ctx) {
  return Container(
    width: MediaQuery.of(ctx).size.width - 28, // minus padding listview
    padding: const EdgeInsets.only(left: 12, right: 20),
    alignment: Alignment.centerRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const HeightSpace(12),
        Image.asset(
          'assets/ruby/ruby_wink_wave.png',
          height: 110,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                ShowCaseWidget.of(ctx).dismiss();
                nav.pop();
                if (firstComponentFilled) {
                  await showcaseIncompleteComponent();
                } else {
                  backFromAddComponent = true;
                  await showcaseComponentPage(back: true);
                }
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
              !firstComponentFilled
                  ? 'Disini kamu bisa mengisi komponen penilaian '
                      'milik mata kuliah yang kamu ambil!'
                  : 'Sekarang, mari kita coba untuk mengisi nilai UAS '
                      'kamu dengan bobot 50%',
              style: FontTheme.poppins14w700black().copyWith(
                fontSize: 13,
                color: BaseColors.white,
              ),
            ),
          ],
        ),
        const HeightSpace(8),
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
                      ShowCaseWidget.of(ctx).dismiss();
                      if (firstComponentFilled) {
                        await showcaseAddComponentScore();
                      } else {
                        await showcaseAddComponentName();
                      }
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

Widget componentNameShowcase(BuildContext ctx) {
  return Container(
    width: MediaQuery.of(ctx).size.width - 24,
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeightSpace(16),
        InkWell(
          onTap: () {
            ShowCaseWidget.of(ctx).dismiss();
            showcaseAddComponentFields();
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
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Kamu bisa mengisi nama komponen lewat tombol dropdown '
                    'di kanan atau diketik sendiri.\n\n',
                style: FontTheme.poppins14w700black().copyWith(
                  fontSize: 13,
                  color: BaseColors.white,
                ),
              ),
              TextSpan(
                text: 'Kali ini, aku coba isi "UTS" ya!',
                style: FontTheme.poppins14w700black().copyWith(
                  fontSize: 13,
                  color: BaseColors.malibu,
                ),
              ),
            ],
          ),
        ),
        const HeightSpace(12),
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
                      await componentFormRM.setState(
                        (s) => s.nameController.text = 'UTS',
                      );
                      await showcaseAddComponentWeight();
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

Widget componentWeightShowcase(BuildContext ctx) {
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
                    await componentFormRM.setState(
                      (s) => s.nameController.clear(),
                    );
                    await showcaseAddComponentName();
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
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Pada bagian ini, kamu bisa mengisi persentase '
                            'bobot pada komponen UTS tadi.\n\n',
                        style: FontTheme.poppins14w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Mari kita coba isi 50% ',
                        style: FontTheme.poppins14w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.malibu,
                        ),
                      ),
                      TextSpan(
                        text: 'untuk bobot UTS ini.',
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
                                ShowCaseWidget.of(ctx).dismiss();
                                await componentFormRM.setState(
                                  (s) => s.weightController.text = '50.0',
                                );
                                await showcaseAddComponentScore();
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
        left: 8,
        top: -240,
        child: Image.asset(
          'assets/ruby/ruby_smile.png',
          height: 125,
        ),
      ),
    ],
  );
}

Widget componentScoreShowcase(BuildContext ctx, int calculatorId) {
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
            const HeightSpace(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowCaseWidget.of(ctx).dismiss();
                    if (firstComponentFilled) {
                      await componentFormRM.setState(
                        (s) {
                          s.nameController.clear();
                          s.weightController.clear();
                          return true;
                        },
                      );
                      await showcaseAddComponentFields();
                    } else {
                      await componentFormRM.setState(
                        (s) => s.weightController.clear(),
                      );
                      await showcaseAddComponentWeight();
                    }
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
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: !firstComponentFilled
                            ? 'Sekarang, mari kita isi nilai '
                                'komponen UTS kamu '
                            : 'Mau tahu nilai UAS yang harus kamu capai '
                                'bulan depan?\n\n',
                        style: FontTheme.poppins14w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.white,
                        ),
                      ),
                      TextSpan(
                        text: !firstComponentFilled
                            ? 'dengan nilai 70!'
                            : 'Kosongkan nilainya, biar Ruby '
                                'yang hitung untukmu.',
                        style: FontTheme.poppins14w700black().copyWith(
                          fontSize: 13,
                          color: BaseColors.malibu,
                        ),
                      ),
                    ],
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
                                ShowCaseWidget.of(ctx).dismiss();
                                if (!firstComponentFilled) {
                                  await componentFormRM.setState(
                                    (s) => s.scoreControllers[0].text = '70',
                                  );
                                }
                                await componentFormRM.state.fakeLoading();
                                await mockComponentRM.state.addComponent(
                                  firstComponentFilled ? 2 : 1,
                                  calculatorId,
                                );
                                nav.pop();
                                if (secondComponentFilled) {
                                  await showcaseTargetScoreComponent();
                                } else {
                                  await showcaseIncompleteComponent();
                                }
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
        top: -220,
        child: Image.asset(
          'assets/ruby/ruby_wink_wave.png',
          height: 110,
        ),
      ),
    ],
  );
}
