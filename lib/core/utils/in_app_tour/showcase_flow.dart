// This will store the flow of the in-app tour

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:ulaskelas/core/theme/_theme.dart';
import 'package:ulaskelas/core/utils/in_app_tour/widgets/_widgets.dart';

import '../../bases/states/_states.dart';
import 'showcase_keys.dart';

InAppTourKeys inAppTourKeys = InAppTourKeys();
BuildContext? navbarContext;
BuildContext? searchPageContext;
BuildContext? detailMatkulContext;

Future<void> showInAppTourOpening(BuildContext ctx) async {
  await Future.delayed(const Duration(milliseconds: 700));

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
                                      onTap: () {
                                        nav.pop();
                                        print('Dialog is about to be popped!');
                                        // await Pref.saveBool('doneAppTour', value: true);
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

Future<void> showcaseCourseDetail() async {
  await Future.delayed(const Duration(milliseconds: 1500));
  ShowCaseWidget.of(detailMatkulContext!).startShowCase([inAppTourKeys.courseDetailDM]);
}

Future<void> showcaseReviewing() async {
  ShowCaseWidget.of(detailMatkulContext!).startShowCase([inAppTourKeys.reviewBySelfDM]);
}

Future<void> showcaseReviews() async {
  ShowCaseWidget.of(detailMatkulContext!).startShowCase([inAppTourKeys.reviewsDM]);
}

Future<void> showcaseNavbarTanyaTeman() async {
  ShowCaseWidget.of(navbarContext!).startShowCase([inAppTourKeys.navbarTanyaTeman]);
}
