part of '_widgets.dart';

class AskQuestionBox extends StatelessWidget {
  const AskQuestionBox({
    this.onTap,
    this.isInDetailPage = false,
    super.key
  });

  final VoidCallback? onTap;
  final bool? isInDetailPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 42.5,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: BaseColors.primary.withOpacity(.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isInDetailPage!
                ? 'Punya solusi? Ayok bantu jawab!'
                : 'Kebingungan? TanyaTeman!',
              style: FontTheme.poppins12w500black().copyWith(
                color: BaseColors.gray1.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}