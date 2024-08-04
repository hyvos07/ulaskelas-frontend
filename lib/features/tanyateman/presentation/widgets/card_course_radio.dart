part of '_widgets.dart';

class CardCourseRadio extends StatelessWidget {
  const CardCourseRadio({
    required this.model,
    this.isChecked = false,
    super.key,
    // this.onTap,
  });

  final CourseModel model;
  // final VoidCallback? onTap;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked);
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
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: isChecked, 
              groupValue: 1, 
              onChanged: (v) {

              }
            )
            // Checkbox(
            //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //   visualDensity: const VisualDensity(
            //     horizontal: -3.5,
            //     vertical: -3.5,
            //   ),
            //   splashRadius: 15,
            //   activeColor: BaseColors.primaryColor,
            //   value: isChecked,
            //   onChanged: onChanged,
            // )
          ],
        ),
      ),
    );
  }

  void onChanged(bool? isChecked) {
    if (isChecked != null) {
      if (isChecked) {
        searchCourseRM.state.addCourse(model);
      } else {
        searchCourseRM.state.removeCourse(model);
      }
    }

    if (kDebugMode) {
      final printCourses = <String>[];
      for (final course in searchCourseRM.state.selectedCourses) {
        printCourses.add(course.name!);
      }
      print(printCourses);
    }
  }
}
