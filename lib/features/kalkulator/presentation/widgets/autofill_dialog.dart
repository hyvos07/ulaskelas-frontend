part of '_widgets.dart';

class AutoFillSemesterDialog extends StatefulWidget {
  const AutoFillSemesterDialog({
    required this.avaibleSemesters,
    super.key,
  });

  final List<SemesterModel> avaibleSemesters;

  @override
  _AutoFillSemesterDialogState createState() => _AutoFillSemesterDialogState();
}

class _AutoFillSemesterDialogState extends State<AutoFillSemesterDialog> {
  List<String> selectedSemesterList = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
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
                top: -15,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close_rounded, 
                    size: 30,
                    color: Color(0xFF828282),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rekomendasi Mata kuliah untuk jurusan kamu!', 
                style: FontTheme.poppins12w400black(),
              ),
              Text(
                '*Only available for Faculty of Computer Science for now.',
                style: FontTheme.poppins6w400black()
                    .copyWith(color: BaseColors.mineShaft.withOpacity(0.6)),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ],
      ),
      content: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  widget.avaibleSemesters.length, (index) {
                  final semester = widget.avaibleSemesters[index];
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
          SimpanButton(
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
