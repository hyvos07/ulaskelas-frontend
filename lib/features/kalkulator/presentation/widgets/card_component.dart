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
          child: CustomTableRow(
            style: FontTheme.poppins12w400black(),
            components: [
              CustomTableRowComponent(
                flexRatio: 50, 
                text: name,
              ),
              CustomTableRowComponent(
                flexRatio: 20, 
                text: score == null ? 'Kosong' : score!.toStringAsFixed(2),
                textAlign: TextAlign.right,
              ),
              CustomTableRowComponent(
                flexRatio: 18, 
                text: '${weight.toStringAsFixed(0)}%',
                textAlign: TextAlign.right,
              ),
              CustomTableRowComponent(
                flexRatio: 18, 
                isGradient: score == 0 || score == null,
                text: score == 0 || score == null
                  ? componentRM.state.hasReachedMax
                      ? hope!.toStringAsFixed(2)
                      : ''
                  : componentRM.state.hasReachedMax
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
