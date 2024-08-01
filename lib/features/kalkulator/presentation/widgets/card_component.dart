part of '_widgets.dart';

class CardCompononent extends StatelessWidget {
  const CardCompononent({
    required this.id,
    required this.name,
    required this.score,
    required this.weight,
    required this.hope,
    super.key,
    this.onTap,
  });

  final int id;
  final String name;
  final double? score;
  final double weight;
  final double? hope;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: BaseColors.white,
            boxShadow: BoxShadowDecorator().defaultShadow(context),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: FontTheme.poppins12w400black(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  score == null ? 'Kosong' : score!.toStringAsFixed(2),
                  style: score == null
                    ? FontTheme.poppins12w400black().copyWith(
                      color: BaseColors.gray1.withOpacity(0.4),)
                    : FontTheme.poppins12w400black(),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                child: Text(
                  '${weight.toStringAsFixed(1)}%',
                  style: FontTheme.poppins12w400black(),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                child: score == 0 || score == null
                  ? GradientText(  // kalo gaada score (tunjukin hope)
                    componentRM.state.hasReachedMax
                      ? hope!.toStringAsFixed(2)
                      : '', 
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: BaseColors.autoSystemColor,
                    ),
                    style:FontTheme.poppins12w400black(),
                    textAlign: TextAlign.right,
                  )
                  : Text(  // kalo ada score
                    componentRM.state.hasReachedMax
                      ? score!.toStringAsFixed(2) 
                      : '',
                    style: FontTheme.poppins12w400black(),
                    textAlign: TextAlign.right,
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
