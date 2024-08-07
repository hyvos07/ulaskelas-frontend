part of '_widgets.dart';

class ScoresFieldInput extends StatelessWidget {
  const ScoresFieldInput({
    required this.controllers,
    required this.length,
    required this.onControllerEmpty,
    required this.averageScoreCalculation,
    required this.recommendedScore,
    this.onFieldChanged,
    super.key,
  });

  final List<TextEditingController> controllers;
  final int length;
  final Function(String, int)? onFieldChanged;
  final VoidCallback onControllerEmpty;
  final double Function() averageScoreCalculation;
  final double recommendedScore;

  @override
  Widget build(BuildContext context) {
    final averageScore = averageScoreCalculation() > 200
        ? '???'
        : averageScoreCalculation().toStringAsFixed(2);

    print(controllers.length);
    print(componentFormRM.state.formData.score);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 5),
        childrenPadding: EdgeInsets.zero,
        shape: Border.all(
          color: BaseColors.transparent,
        ),
        collapsedTextColor: BaseColors.neutral100,
        iconColor: BaseColors.neutral100,
        title: Text(
          'Nilai tiap Komponen',
          style: FontTheme.poppins14w400black().copyWith(
            fontSize: 13,
          ),
        ),
        children: [
          for (var i = 0; i < length; i++) _buildSingleField(i),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rata - Rata',
                  style: FontTheme.poppins14w700black().copyWith(
                    fontSize: 13,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 90,
                      alignment: Alignment.center,
                      child: Text(
                        averageScore,
                        style: FontTheme.poppins14w700black().copyWith(
                          fontSize: 13,
                          color: averageScore.trim() == '???'
                              ? BaseColors.error
                              : BaseColors.neutral100,
                        ),
                      ),
                    ),
                    const WidthSpace(5),
                    Container(
                      width: 52,
                      alignment: Alignment.center,
                      child: GradientText(
                        averageScore.trim() == '???'
                            ? '???'
                            : recommendedScore.toStringAsFixed(2),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: averageScore.trim() == '???'
                              ? [BaseColors.error, BaseColors.error]
                              : BaseColors.autoSystemColor,
                        ),
                        style: FontTheme.poppins14w600black().copyWith(
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSingleField(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nilai ${index + 1}',
                style: FontTheme.poppins14w400black().copyWith(
                  fontSize: 13,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                    width: 90,
                    child: TextFormField(
                      controller: _checkController(index),
                      style: FontTheme.poppins12w400black(),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp('[0-9]+[,.]{0,1}[0-9]*'),
                        ),
                      ],
                      onFieldSubmitted: (value) =>
                          onFieldChanged!(value, index + 1),
                      onChanged: (value) => onFieldChanged!(value, index + 1),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                      ),
                    ),
                  ),
                  const WidthSpace(5),
                  _buildRecommendedScore(
                    recommendedScore,
                    _checkController(index).text,
                  ),
                ],
              ),
            ],
          ),
          const HeightSpace(5),
          const Divider(
            color: BaseColors.neutral100,
            thickness: 0.7,
          ),
        ],
      ),
    );
  }

  TextEditingController _checkController(int index) {
    if (controllers.isEmpty) {
      onControllerEmpty();
    }
    return controllers[index];
  }

  Widget _buildRecommendedScore(double value, String score) {
    final text = value.toStringAsFixed(0);
    final scoreFix = double.tryParse(score);

    final gradientColor = scoreFix != null
        ? scoreFix > 200
            ? [BaseColors.danger, BaseColors.danger]
            : BaseColors.autoSystemColor
        : BaseColors.autoSystemColor;

    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColor,
        ),
      ),
      child: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(vertical: 7.25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: BaseColors.white,
        ),
        child: Center(
          child: score.isEmpty
              ? GradientText(
                  text,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: BaseColors.autoSystemColor,
                  ),
                  style: FontTheme.poppins12w500black(),
                )
              : Text(
                  scoreFix != null && scoreFix <= 200
                      ? scoreFix == scoreFix.floor()
                          ? scoreFix.toStringAsFixed(0)
                          : scoreFix.toStringAsFixed(2)
                      : '???',
                  style: FontTheme.poppins12w500black().copyWith(
                    color: (scoreFix ?? 0) > 200 ? BaseColors.danger : null,
                  ),
                ),
        ),
      ),
    );
  }
}
