// This will store the flow of the in-app tour

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:ulaskelas/core/theme/_theme.dart';

import '../../../services/_services.dart';
import '../../bases/states/_states.dart';
import 'showcase_keys.dart';
import 'widgets/_widgets.dart';

InAppTourKeys inAppTourKeys = InAppTourKeys();

Function(int index) navbarController = (index) {};
VoidCallback backToDetailPage = () {};
VoidCallback backToMatkulCalcPage = () {};

Map<String, dynamic> targetSemester = {};

BuildContext? navbarContext;
BuildContext? searchPageContext;
BuildContext? detailMatkulContext;
BuildContext? tanyaTemanContext;
BuildContext? calculatorContext;
BuildContext? semesterContext;
BuildContext? matkulCalcContext;

bool backFromTanyaTeman = false;
bool backFromCalculator = false;
bool backFromNavbarProfile = false;
bool userHasUsedAutoFill = false;

Future<void> showInAppTourOpening(BuildContext ctx, {bool back = false}) async {
  if (!back) {
    await Future.delayed(const Duration(milliseconds: 700));
  } else {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  await showGeneralDialog(
    context: ctx,
    barrierLabel: 'InAppTourOpening',
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return WillPopScope(
        onWillPop: () async {
          print('Dialog is about to be popped!');
          // await Pref.saveBool('doneAppTour', value: true);
          return true;
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00E4E4E4),
                    Color(0x7FE4E4E4),
                    Color(0xB25D5D5D),
                    Color(0xE53A3A3A)
                  ],
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                ),
                child: Material(
                  color: BaseColors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedImage(
                        child: Image.asset(
                          'assets/ruby/ruby_smile.png',
                          height: 135,
                        ),
                      ),
                      const HeightSpace(12),
                      Container(
                        decoration: const BoxDecoration(
                          color: BaseColors.white,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Perkenalkan aku Ruby! Senang kamu bergabung!',
                              style: FontTheme.poppins14w600black().copyWith(
                                color: BaseColors.mineShaft,
                              ),
                            ),
                            const HeightSpace(20),
                            Text(
                              'Yuk, kita tur singkat Aplikasi TemanKuliah!',
                              style: FontTheme.poppins12w500black().copyWith(
                                fontSize: 13,
                                color: BaseColors.mineShaft,
                              ),
                            ),
                            const HeightSpace(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: InkWell(
                                      onTap: () async {
                                        nav.pop();
                                        print('Dialog is about to be popped!');
                                        await Pref.saveBool(
                                          'doneAppTour',
                                          value: true,
                                        );
                                      },
                                      child: Text(
                                        'Lewati',
                                        style: FontTheme.poppins14w700black()
                                            .copyWith(
                                          color: BaseColors.gray3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const WidthSpace(14),
                                Expanded(
                                  child: SecondaryButton(
                                    height: 30,
                                    borderRadius: BorderRadius.circular(8),
                                    backgroundColor: BaseColors.primary,
                                    text: 'Ikuti Tur',
                                    onPressed: () async {
                                      nav.pop();
                                      await Future.delayed(
                                        const Duration(milliseconds: 200),
                                        showcaseNavbarMatkul,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const HeightSpace(5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}

Future<void> showcaseNavbarMatkul() async {
  ShowCaseWidget.of(navbarContext!).startShowCase([inAppTourKeys.navbarMatkul]);
}

Future<void> showcaseSearchPage() async {
  ShowCaseWidget.of(searchPageContext!).startShowCase([
    inAppTourKeys.searchBarSP,
    inAppTourKeys.filterSP,
    inAppTourKeys.coursecardSP,
  ]);
}

Future<void> showcaseCourseDetail({bool back = false}) async {
  if (!back) {
    await Future.delayed(const Duration(milliseconds: 1500));
  }
  ShowCaseWidget.of(detailMatkulContext!)
      .startShowCase([inAppTourKeys.courseDetailDM]);
}

Future<void> showcaseReviewing() async {
  ShowCaseWidget.of(detailMatkulContext!)
      .startShowCase([inAppTourKeys.reviewBySelfDM]);
}

Future<void> showcaseReviews() async {
  ShowCaseWidget.of(detailMatkulContext!)
      .startShowCase([inAppTourKeys.reviewsDM]);
}

Future<void> showcaseNavbarTanyaTeman({VoidCallback? onBack}) async {
  if (onBack != null) {
    backToDetailPage = onBack;
  }

  ShowCaseWidget.of(navbarContext!)
      .startShowCase([inAppTourKeys.navbarTanyaTeman]);
}

Future<void> showcaseTanyaTeman({
  bool back = false,
  bool previous = false,
}) async {
  if (!(back || previous)) {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  ShowCaseWidget.of(tanyaTemanContext!).startShowCase([
    if (!back) inAppTourKeys.userBoxTT,
    inAppTourKeys.searchBarTT,
  ]);
}

Future<void> showcaseNavbarCalc() async {
  ShowCaseWidget.of(navbarContext!).startShowCase([inAppTourKeys.navbarCalc]);
}

Future<void> showcaseEmptySemester({
  bool back = false,
  bool previous = false,
}) async {
  if (!(back || previous)) {
    await Future.delayed(const Duration(milliseconds: 1200));
  }

  ShowCaseWidget.of(calculatorContext!).startShowCase([
    if (!back) inAppTourKeys.emptySemesterGC,
    inAppTourKeys.autoFillGC,
  ]);
}

Future<void> showcaseFilledSemester({
  bool back = false,
  bool previous = false,
}) async {
  if (!(back || previous)) {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  ShowCaseWidget.of(calculatorContext!).startShowCase([
    if (!back) inAppTourKeys.filledSemesterGC,
    inAppTourKeys.semesterCardGC,
  ]);
}

Future<void> showcaseSemesterPage({bool back = false}) async {
  if (!back) {
    await Future.delayed(const Duration(milliseconds: 800));
  } else {
    await Future.delayed(const Duration(milliseconds: 200));
  }
  ShowCaseWidget.of(semesterContext!)
      .startShowCase([inAppTourKeys.courseCardGC]);
}

Future<void> showcaseComponentPage({
  bool back = false,
  bool previous = false,
}) async {
  if (!previous) {
    await Future.delayed(const Duration(milliseconds: 800));
  }
  ShowCaseWidget.of(matkulCalcContext!).startShowCase([
    if (!back) inAppTourKeys.finalScoreGC,
    inAppTourKeys.totalComponentGC,
  ]);
}

Future<void> showcaseNavbarProfile() async {
  ShowCaseWidget.of(navbarContext!).startShowCase([
    inAppTourKeys.navbarProfile,
  ]);
}

Future<void> showInAppTourClosing(BuildContext ctx) async {
  await Future.delayed(const Duration(milliseconds: 700));

  backFromCalculator = false;
  backFromNavbarProfile = false;
  backFromTanyaTeman = false;
  userHasUsedAutoFill = false;

  await showGeneralDialog(
    context: ctx,
    barrierLabel: 'InAppTourClosing',
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00E4E4E4),
                    Color(0x7FE4E4E4),
                    Color(0xB25D5D5D),
                    Color(0xE53A3A3A)
                  ],
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                ),
                child: Material(
                  color: BaseColors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedImage(
                        child: Image.asset(
                          'assets/ruby/ruby_dead.png',
                          height: 135,
                        ),
                      ),
                      const HeightSpace(12),
                      Container(
                        decoration: const BoxDecoration(
                          color: BaseColors.white,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sekian dari Aku, Ruby!',
                              style: FontTheme.poppins14w600black().copyWith(
                                color: BaseColors.mineShaft,
                              ),
                            ),
                            const HeightSpace(20),
                            Text(
                              'Sedih berpisah denganmu, akan tetapi kita akan '
                              'bertemu kembali di lain waktu! Sampai jumpa!!',
                              style: FontTheme.poppins12w500black().copyWith(
                                fontSize: 13,
                                color: BaseColors.mineShaft,
                              ),
                            ),
                            const HeightSpace(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: InkWell(
                                      onTap: () async {
                                        nav.pop();
                                        navbarController(0);
                                        print('Restarting...');
                                        await showInAppTourOpening(
                                          navbarContext!,
                                        );
                                      },
                                      child: Text(
                                        'Ulangi Tur',
                                        style: FontTheme.poppins14w700black()
                                            .copyWith(
                                          color: BaseColors.gray3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const WidthSpace(14),
                                Expanded(
                                  child: SecondaryButton(
                                    height: 30,
                                    borderRadius: BorderRadius.circular(8),
                                    backgroundColor: BaseColors.primary,
                                    text: 'Selesai',
                                    onPressed: () async {
                                      nav.pop();
                                      navbarController(0);
                                      print('User Done!');
                                      await Pref.saveBool(
                                        'doneAppTour',
                                        value: true,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const HeightSpace(5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}
