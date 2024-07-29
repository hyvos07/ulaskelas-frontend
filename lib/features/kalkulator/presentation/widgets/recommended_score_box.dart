part of '_widgets.dart';

class RecommendedScoreBox extends StatelessWidget {
  const RecommendedScoreBox({
    required this.value,
    required this.score,
    super.key,
  });

  final double value;
  final String score;

  @override
  Widget build(BuildContext context) {
    final text = value.toStringAsFixed(0);
    final scoreFix = double.tryParse(score);

    final gradientColor = scoreFix != null
        ? scoreFix > 200
            ? [BaseColors.danger, BaseColors.danger]
            : BaseColors.autoSystemColor
        : BaseColors.autoSystemColor;
    
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColor,
        ),
      ),
      child: Container(
        width: 63,
        padding: const EdgeInsets.symmetric(vertical: 13.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.5),
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
                  style: FontTheme.poppins14w500black().copyWith(
                    fontSize: 13.5,
                  ),
                )
              : Text(
                  scoreFix != null && scoreFix <= 200
                      ? scoreFix == scoreFix.floor()
                          ? scoreFix.toStringAsFixed(0)
                          : scoreFix.toStringAsFixed(2)
                      : '???',
                  style: FontTheme.poppins14w500black().copyWith(
                    fontSize: 13.5,
                    color: scoreFix! > 200 ? BaseColors.danger : null,
                  ),
                ),
        ),
      ),
    );
  }
}
