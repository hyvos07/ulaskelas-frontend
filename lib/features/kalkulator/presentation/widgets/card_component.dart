part of '_widgets.dart';

class CardCompononent extends StatelessWidget {
  const CardCompononent({
    required this.id,
    required this.name,
    required this.score,
    required this.weight,
    this.hope,
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
    final stateRM;

    if (Pref.getBool('doneAppTour') == false ||
        Pref.getBool('doneAppTour') == null) {
      stateRM = mockComponentRM.state;
    } else {
      stateRM = componentRM.state;
    }

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
          child: CustomTableRow(
            style: FontTheme.poppins12w400black(),
            components: [
              CustomTableRowComponent(
                flexRatio: 50,
                text: name,
              ),
              CustomTableRowComponent(
                flexRatio: 30,
                text: score == -1.00 ? 'Kosong' : score!.toStringAsFixed(2),
                textAlign: TextAlign.right,
                isGradient: score == -1.00,
                gradientColors: [
                  BaseColors.gray3,
                  BaseColors.gray3,
                ],
              ),
              CustomTableRowComponent(
                flexRatio: 28,
                text: '${formatDouble(weight)}%',
                textAlign: TextAlign.right,
              ),
              CustomTableRowComponent(
                flexRatio: 28,
                isGradient: score == 0 || score == -1.00,
                text: score == 0 || score == -1.00
                    ? stateRM.hasReachedMax && stateRM.canGiveRecom
                        ? hope!.toStringAsFixed(2)
                        : ''
                    : stateRM.hasReachedMax && stateRM.canGiveRecom
                        ? score!.toStringAsFixed(2)
                        : '',
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
