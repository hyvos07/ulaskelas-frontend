// ignore_for_file: lines_longer_than_80_chars

part of '_pages.dart';

class CalculatorComponentPage extends StatefulWidget {
  const CalculatorComponentPage({
    required this.givenSemester,
    required this.calculatorId,
    required this.courseId,
    required this.courseName,
    required this.totalScore,
    required this.totalPercentage,
    super.key,
  });

  final String givenSemester;
  final int calculatorId;
  final int courseId;
  final String courseName;
  final double totalScore;
  final double totalPercentage;

  @override
  _CalculatorComponentPageState createState() =>
      _CalculatorComponentPageState();
}

class _CalculatorComponentPageState
    extends BaseStateful<CalculatorComponentPage> {
  late ScrollController scrollController;
  Completer<void>? completer;

  @override
  void init() {
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: false,
      cacheKey: componentRM.state.cacheKey!,
    ).initialize();
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Tambah Nilai Mata Kuliah',
      onBackPress: onBackPressed,
    );
  }

  String _selectedItem = 'A (85.00)';
  final List<String> _nilaiHarapanList = [
    'A (85.00)',
    'A- (80.00)',
    'B+ (75.00)',
    'B (70.00)',
    'B- (65.00)',
    'C+ (60.00)',
    'C (55.00)'
  ];

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return RefreshIndicator(
      onRefresh: retrieveData,
      key: refreshIndicatorKey,
      child: OnBuilder<ComponentState>.all(
        listenTo: componentRM,
        onIdle: () => const SizedBox.shrink(),
        onWaiting: () => const SizedBox.shrink(),
        onError: (dynamic error, refresh) => Text(error.toString()),
        onData: (data) {
          final components = data.components;
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        widget.courseName,
                        style: FontTheme.poppins20w700black(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nilai Akhir',
                          style: FontTheme.poppins14w400black(),
                        ),
                        Text(
                          _getFinalScoreAndGrade(widget.totalScore),
                          style: FontTheme.poppins14w600black(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Harapan',
                          style: FontTheme.poppins14w400black(),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              // ignore: deprecated_member_use
                              color: componentRM.state.hasReachedMax
                                ? null
                                : BaseColors.gray1.withOpacity(0.3),
                            ),
                            const SizedBox(width: 6,),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 1.75, vertical: 1.75),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: componentRM.state.hasReachedMax
                                      ? BaseColors.autoSystemColor
                                      : [BaseColors.gray1.withOpacity(0.3), 
                                        BaseColors.gray1.withOpacity(0.3)],
                                  ),
                                  borderRadius: BorderRadius.circular(6.5),
                                ),
                              child: Container(
                                height: 30,
                                padding: const EdgeInsets.only(left: 10,),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.5),
                                ),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  value: _selectedItem,
                                  onChanged: componentRM.state.hasReachedMax
                                    ? (String? newValue) {
                                        setState(() {
                                          _selectedItem = newValue!;
                                        });
                                      }
                                    : null
                                  ,
                                  selectedItemBuilder: (BuildContext context) {
                                    return _nilaiHarapanList.map<Widget>((String value) {
                                      return Center(
                                        child: GradientText(
                                          value,
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: componentRM.state.hasReachedMax
                                              ? BaseColors.autoSystemColor
                                              : [BaseColors.gray1.withOpacity(0.3), 
                                                BaseColors.gray1.withOpacity(0.3)],
                                          ),
                                          style: FontTheme.poppins14w500black(),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  items: _nilaiHarapanList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
                                          decoration: BoxDecoration(
                                            color: _selectedItem == value
                                              ? BaseColors.mineShaft.withOpacity(0.125)
                                              : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            value,
                                            style: FontTheme.poppins14w500black().copyWith(
                                              fontSize: 13.5,
                                              color: BaseColors.mineShaft.withOpacity(0.85),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  icon: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: componentRM.state.hasReachedMax
                                          ? BaseColors.autoSystemColor
                                          : [BaseColors.gray1.withOpacity(0.3), 
                                            BaseColors.gray1.withOpacity(0.3)],
                                      ).createShader(bounds);
                                    },
                                    child: const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Komponen',
                              style: FontTheme.poppins12w600black(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Nilai',
                              style: FontTheme.poppins12w600black(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Bobot',
                              style: FontTheme.poppins12w600black(),
                            ),
                          ),
                          Flexible(
                            child: GradientText(
                              'Harapan', 
                              style: FontTheme.poppins12w600black()
                                  .copyWith(),
                              textAlign: TextAlign.right,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: componentRM.state.hasReachedMax
                                  ? BaseColors.autoSystemColor
                                  : [BaseColors.gray1.withOpacity(0.3),
                                    BaseColors.gray1.withOpacity(0.3),],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    if (components.isEmpty) Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                'Belum Ada Komponen',
                                style: FontTheme.poppins12w500black(),
                              ),
                            ),
                          ) else ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 20),
                          itemCount: componentRM.state.components.length,
                          itemBuilder: (context, index) {
                            final component = components[index];
                            return CardCompononent(
                              id: component.id!,
                              name: component.name!,
                              score: component.score,
                              weight: component.weight!,
                              hope: componentRM.state.hasReachedMax
                                ? 85
                                : null,
                              onTap: () {
                                nav.goToEditComponentPage(
                                  id: component.id!,
                                  givenSemester: component.givenSemester!,
                                  courseId: component.courseId!,
                                  calculatorId: widget.calculatorId,
                                  courseName: widget.courseName,
                                  totalScore: widget.totalScore,
                                  totalPercentage: widget.totalPercentage,
                                  componentName: component.name!,
                                  componentScore: component.score!,
                                  componentWeight: component.weight!,
                                );
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 1),
                        )
                    ,
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${componentRM.state.components.length} Komponen',
                            style: FontTheme.poppins12w600black(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${componentRM.state.totalScore}',
                            style: FontTheme.poppins12w600black(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${componentRM.state.totalWeight}%',
                            style: FontTheme.poppins12w600black(),
                          ),
                        ),
                        Flexible(
                          child: GradientText(
                            componentRM.state.hasReachedMax // dummy data
                              ? '55.87'
                              : '', 
                            style: FontTheme.poppins12w600black()
                                .copyWith(),
                            textAlign: TextAlign.right,
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: BaseColors.autoSystemColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    const HeightSpace(30),
                    SecondaryButton(
                      width: double.infinity,
                      text: 'Tambah Komponen',
                      backgroundColor: BaseColors.purpleHearth,
                      onPressed: () {
                        nav.goToComponentFormPage(
                          givenSemester: widget.givenSemester,
                          courseId: widget.courseId,
                          calculatorId: widget.calculatorId,
                          courseName: widget.courseName,
                          totalScore: widget.totalScore, 
                          totalPercentage: widget.totalPercentage,
                        );
                      },
                    ),
                    const HeightSpace(70),
                    Center(
                      child: InkWell(
                        onTap: () {
                          nav.pop();
                          calculatorRM.setState(
                            (s) => s.deleteCalculator(
                              query: QueryCalculator(
                                courseId: widget.courseId,
                              ),
                              givenSemester: widget.givenSemester,
                              courseName: widget.courseName,
                              totalScore: widget.totalScore,
                            ),
                          );
                        },
                        child: Text(
                          'Hapus Kalkulator Mata Kuliah',
                          style: FontTheme.poppins14w500black().copyWith(
                            color: BaseColors.error,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
    nav.pop();
    await calculatorRM.state.retrieveData(widget.givenSemester);
    return true;
  }

  String _getFinalScoreAndGrade(double score) {
    var grade = 'E';
    if (score >= 85) {
      grade = 'A';
    } else if (score >= 80) {
      grade = 'A-';
    } else if (score >= 75) {
      grade = 'B+';
    } else if (score >= 70) {
      grade = 'B';
    } else if (score >= 65) {
      grade = 'B-';
    } else if (score >= 60) {
      grade = 'C+';
    } else if (score >= 55) {
      grade = 'C';
    } else if (score >= 40) {
      grade = 'D';
    }

    return '$grade (${score.toStringAsFixed(2)})';
  }

  Future<void> retrieveData() async {
    await componentRM.setState(
      (s) => s.retrieveData(
        QueryComponent(
          calculatorId: widget.calculatorId,
        ),
      ),
    );
  }
}
