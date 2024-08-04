part of '_widgets.dart';

class HistoryQuestion extends StatelessWidget {
  const HistoryQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Semua Pertanyaan',
                style: FontTheme.poppins12w700black().copyWith(
                  fontWeight: FontWeight.w600,
                  color: BaseColors.gray1,
                ),
              )
            ],
          ),
          const HeightSpace(10),
          const CardPost(),
        ],
      ),
    );
  }
}
