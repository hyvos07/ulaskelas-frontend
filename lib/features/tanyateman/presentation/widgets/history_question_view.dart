part of '_widgets.dart';

class HistoryQuestion extends StatelessWidget {
  const HistoryQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
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
          const HeightSpace(20),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: BaseColors.white,
              boxShadow: BoxShadowDecorator().defaultShadow(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const HeightSpace(100),
                SizedBox(
                  height: 200,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: BaseColors.gray3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
