part of '_widgets.dart';

class AutoFillSemesterDialog extends StatefulWidget {
  const AutoFillSemesterDialog({
    required this.availableSemesters,
    super.key,
  });

  final List<SemesterModel> availableSemesters;

  @override
  _AutoFillSemesterDialogState createState() => _AutoFillSemesterDialogState();
}

class _AutoFillSemesterDialogState extends State<AutoFillSemesterDialog> {
  List<String> selectedSemesterList = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        vertical: 50, horizontal: 30,
      ),
      titlePadding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      contentPadding: const EdgeInsets.only(
        top: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade500,)
      ),
      elevation: 5,
      title: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Auto-fill Semester',
                    style: FontTheme.poppins16w700black(),
                  ),
                ),
              ),
              Positioned(
                right: -15,
                top: -5,
                child: IconButton(
                  onPressed: () => nav.pop(),
                  icon: Icon(
                    Icons.close_rounded,
                    size: 30,
                    color: BaseColors.gray2,
                    shadows: List.generate(10, (index) {
                      return const Shadow(
                        color: BaseColors.gray2,
                        blurRadius: 1.5,
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rekomendasi Mata kuliah untuk jurusan kamu!', 
                  style: FontTheme.poppins12w400black(),
                ),
                const HeightSpace(5),
                Text(
                  '*Only available for Faculty of Computer Science for now.',
                  style: FontTheme.poppins6w400black()
                      .copyWith(color: BaseColors.mineShaft.withOpacity(0.6)),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
      content: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10, right: 10, top: 10
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    widget.availableSemesters.length, (index) {
                    final semester = widget.availableSemesters[index];
                    return ExpansionCard(
                      title: 'Semester ${semester.givenSemester}',
                      children: semester.courseList,
                      onCheckboxChanged: (isChecked) {
                        setState(() {
                          if (isChecked) {
                            selectedSemesterList.add(semester.givenSemester!);
                          } else {
                            selectedSemesterList.remove(semester.givenSemester);
                          }
                        });
                      },
                    );
                  }),
                ),
              ),
            ),
          ),
          SimpanButton(
            isForAutoFill: true,
            onTap: () {
              selectedSemesterList
                  .sort((a, b) => int.parse(a).compareTo(int.parse(b)));
              final model = <String, dynamic>{
                'given_semesters': selectedSemesterList,
              };
              semesterRM.state.postAutoFillSemester(model);
              Navigator.of(context).pop();
            },
            text: 'Tambah Semester',
          ),
        ],
      ),
    );
  }
}
