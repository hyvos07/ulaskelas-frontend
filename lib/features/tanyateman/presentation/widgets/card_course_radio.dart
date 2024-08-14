part of '_widgets.dart';

class CardCourseRadio extends StatelessWidget {
  const CardCourseRadio({
    required this.model,
    super.key,
    // this.onTap,
  });

  final CourseModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        searchCourseRM.state.addCourseRadioType(model);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: BaseColors.white,
          boxShadow: BoxShadowDecorator().defaultShadow(context),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    style: FontTheme.poppins12w400black(),
                  ),
                ],
              ),
            ),
            const WidthSpace(20),
            Radio(
              activeColor: BaseColors.accentColor,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: model,
              groupValue: searchCourseRM.state.selectedCourses[0],
              onChanged: (e) {
                searchCourseRM.state.addCourseRadioType(model);
              }
            )
          ],
        ),
      ),
    );
  }
}
