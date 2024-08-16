part of '_widgets.dart';


class CoursePicker extends StatelessWidget {
  const CoursePicker({
    required this.onTap,
    super.key
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: BaseColors.mineShaft.withOpacity(0.35)
          )
        ),
        child: Row(
          children: [
            Expanded(
              flex: 11,
              child: Text(
                questionFormRM.state.course == null
                  ?'Matkul Terkait'
                  : questionFormRM.state.course!.name!,
                style: FontTheme.poppins12w400black().copyWith(
                  color: Colors.grey.shade600
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Icon(
                Icons.arrow_drop_down_rounded,
                size: 28,
                color: Colors.grey.shade600,
              ),
            )
          ],
        )
      ),
    );
  }
}