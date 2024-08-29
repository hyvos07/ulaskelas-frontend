// Created by Muhamad Fauzi Ridwan on 08/11/21.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/theme/_theme.dart';
import 'package:ulaskelas/services/_services.dart';

import 'core/bases/states/_states.dart';
import 'core/constants/_constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
  });

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends BaseStateful<OnboardingPage> {
  final PageController pageController = PageController();
  int pageIndex = 0;

  List<String> titles = [
    'Selamat datang di TemanKuliah!',
    'Dikusi dan Ulasan Kelas',
    'Kalkulator Menghitung Nilai',
  ];

  List<Widget> descriptionWidgets = [
    buildDescription(
      '''
  TemanKuliah adalah All-in-One App yang 
  akan menemani perjalanan kuliahmu 
  dengan fitur - fitur yang ada''',
      'All-in-One App',
    ),
    Text(
      '''
  Kamu dapat berdiskusi melalui forum 
  diskusi dan kamu juga dapat memberi serta 
  membaca ulasan seluruh kelas loh!''',
      style: FontTheme.poppins14w400black(),
      textAlign: TextAlign.center,
    ),
    Text(
      '''
  Tidak perlu bingung melakukan kalkulasi 
  nilai, terdapat fitur untuk menghitung nilai, 
  IPK, dan rekomendasi nilai terbaik!''',
      style: FontTheme.poppins14w400black(),
      textAlign: TextAlign.center,
    ),
  ];

  @override
  void init() {}

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    final width = sizeInfo.screenSize.width;
    final height = sizeInfo.screenSize.height;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                pageIndex = value;
              });
            },
            itemCount: titles.length,
            itemBuilder: (context, index) {
              return OnboardingPageBody(
                index: index,
                height: height,
                width: width,
                title: titles[index],
                descriptionWidgets: descriptionWidgets[index],
                image: 'assets/images/ilust_onboard${index + 1}.png',
              );
            },
          ),
          Positioned(
            top: height / 17.5, right: 0,
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: width / 20),
              child: InkWell(
                onTap: nav.replaceToSsoPage,
                child: Text(
                  'Lewati',
                  style: FontTheme.poppins14w600black().copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DotIndicator(
            currentIndex: pageIndex,
            length: 3,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width / 15,
              vertical: height / 30,
            ),
            child: AutoLayoutButton(
              text: (pageIndex == 2) ? 'Mulai' : 'Selanjutnya',
              backgroundColor: BaseColors.purpleHearth,
              onTap: () async {
                if (pageIndex < 2) {
                  await pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                  );
                } else {
                  await Pref.saveBool(PreferencesKeys.onBoard, value: true);
                  await nav.replaceToSsoPage();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }
}

class OnboardingPageBody extends StatelessWidget {
  const OnboardingPageBody({
    required this.index,
    required this.height,
    required this.width,
    required this.title,
    required this.descriptionWidgets,
    required this.image,
    super.key,
  });

  final int index;
  final double height;
  final double width;
  final String title;
  final Widget descriptionWidgets;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: height / 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Stack(
              children: [
                Container(
                    color: Colors.grey.withOpacity(0.1), 
                  ),
                buildIllustration(index)
              ],
            )
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(
                left: width / 15,
                right: width / 15,
                top: height / 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: FontTheme.poppins18w700black(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height / 53.33,
                  ),
                  Flexible(
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) 
                        => SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: descriptionWidgets,
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stack buildIllustration(int pageIndex) {
    if (pageIndex == 0)  {
      return Stack(
        children: [
          Positioned(
            bottom: - (height / 3.5),
            child: Image.asset(
              'assets/onboarding/dragon_scales.png',
              scale: 1.75,
            ),
          ),
          Image.asset(
            'assets/onboarding/aurora_top_left_1.png',
            scale: 1.75,
          ),
          Center(
            child: Image.asset(
              'assets/ruby/ruby_wave_rotate.png',
              scale: 3,
              ),
          ),
          Transform.translate(
            offset: Offset(width / 4, - (height/10)),
            child: Center(
              child: Image.asset(
                'assets/onboarding/hi_dialog.png',
                scale:1.75,
              ),
            ),
          ),
        ],
      );
    }
    
    if (pageIndex == 1) {
      return Stack(
        children: [
          Image.asset(
            'assets/onboarding/aurora_top_left_2.png',
            scale: 1.75,
          ),
          Positioned(
            bottom: - (height/3.5),
            right: 0,
            child: Image.asset(
              'assets/onboarding/aurora_bottom_right_2.png',
              scale: 1.75,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Expanded(flex: 2,child: SizedBox.shrink(),),
                  Expanded(
                    flex: 10,
                    child: Image.asset(
                      'assets/onboarding/ulasan_papers.png',
                      scale: 1.5,
                    ),
                  )
                ],
              )
            ],
          ),
          Positioned(
            top: height / 4.25,
            child: Image.asset(
              'assets/ruby/ruby_left_question_mark.png',
              scale: 1.8,
            ),
          ),
          Positioned(
            right: 0,
            top: height / 4.75,
            child: Image.asset(
              'assets/ruby/ruby_right_exclamation_mark.png',
              scale: 1.8,
            ),
          )
        ],
      );
    }

    return Stack(
      children: [
        Positioned(
          bottom: - (height/4),
          child: Image.asset(
            'assets/onboarding/aurora_bottom_left_3.png',
            scale: 1.75,
          ),
        ),
        Positioned(
          bottom: - (height/5),
          right: 0,
          child: Image.asset(
            'assets/onboarding/aurora_bottom_right_3.png',
            scale: 1.75,
          ),
        ),
         Positioned(
            bottom: - (height / 50),
            left: width / 2.75,
            child: Image.asset(
              'assets/onboarding/target_scores.png',
              scale: 1.6,
            ),
          ),
        Transform.translate(
          offset: Offset(- (width/7), -(height/20)),
          child: Center(
            child: Image.asset(
              'assets/ruby/ruby_calculate.png',
              scale: 1.5,
            ),
          ),
        ), 
      ],
    );
  }
}

Widget buildDescription(String text, String italicPart) {
  List<TextSpan> spans = [];
  List<String> parts = text.split(italicPart);

  spans.add(TextSpan(text: parts[0], style: FontTheme.poppins14w400black()));

  spans.add(TextSpan(
    text: italicPart,
    style: FontTheme.poppins14w400black().copyWith(fontStyle: FontStyle.italic),
  ));

  if (parts.length > 1) {
    spans.add(TextSpan(text: parts[1], style: FontTheme.poppins14w400black()));
  }

  return Text.rich(
    TextSpan(children: spans),
    textAlign: TextAlign.center,
  );
}
