part of '_widgets.dart';

class CardSemester extends StatelessWidget {
  const CardSemester({
    required this.model, super.key,
    this.onTap,
  });

  final SemesterModel model;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 17.5,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: BaseColors.white,
          boxShadow: BoxShadowDecorator().defaultShadow(context),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Semester ${model.givenSemester}',
              style: FontTheme.poppins14w700black().copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const HeightSpace(2),
            Text(
              model.semesterGPA?.toStringAsFixed(2) ?? '0.00',
              style: FontTheme.poppins12w400black(),
            ),
            const HeightSpace(1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  decoration: BoxDecoration(
                    color: BaseColors.gray3.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const SizedBox(
                    width: 50,
                    height: 3,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
