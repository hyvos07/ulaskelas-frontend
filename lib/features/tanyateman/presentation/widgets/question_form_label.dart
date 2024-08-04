part of '_widgets.dart';

class QuestionFormLabel extends StatelessWidget {
  const QuestionFormLabel({
    required this.text, 
    this.bottomPad,
    this.topPad,
    this.rightPad,
    this.leftPad,
    this.color,
    super.key
  });

  final String text;
  final double? bottomPad;
  final double? topPad;
  final double? rightPad;
  final double? leftPad;
  final Color?  color;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPad ?? 0,
        top: topPad ?? 0,
        right: rightPad ?? 0,
        left: leftPad ?? 0,
      ),
      child: Text(
        text,
        style: FontTheme.poppins12w600black()
          .copyWith(color: color ?? BaseColors.mineShaft.withOpacity(0.7)),
      ),
    );
  }
}