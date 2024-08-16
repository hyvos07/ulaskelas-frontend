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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: searchCourseRM.state.selectedCourses.isNotEmpty
               && searchCourseRM.state.selectedCourses[0].id == model.id
                  ? BaseColors.accentColor
                  : BaseColors.white,
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
                  style: 
                    searchCourseRM.state.selectedCourses.isNotEmpty
                    && searchCourseRM.state.selectedCourses[0].id == model.id
                      ? FontTheme.poppins12w700white()
                      : FontTheme.poppins12w400black()
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
