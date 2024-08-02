part of '_widgets.dart';

class AddSemesterDialog extends StatefulWidget {
  const AddSemesterDialog({
    required this.semesters,
    required this.userGen,
    required this.onPressed,
    super.key,
  });

  final Function(List<String>) onPressed;
  final List<SemesterModel> semesters;
  final int userGen;

  @override
  State<AddSemesterDialog> createState() => _AddSemesterDialogState();
}

class _AddSemesterDialogState extends State<AddSemesterDialog> {
  final _selectableSemester = <String>[];
  final _selectedSemester = <String>[];
  List<String> _listOfSemester = <String>[];

  @override
  void initState() {
    super.initState();
    _listOfSemester = [
      '1',
      '2',
      'sp_${widget.userGen + 1}',
      '3',
      '4',
      'sp_${widget.userGen + 2}',
      '5',
      '6',
      'sp_${widget.userGen + 3}',
      '7',
      '8',
      'sp_${widget.userGen + 4}',
      '9',
      '10',
      'sp_${widget.userGen + 5}',
      '11',
      '12',
    ];

    for (final givenSemester in _listOfSemester) {
      final isExist = widget.semesters.any(
        (element) => element.givenSemester == givenSemester,
      );
      if (!isExist) {
        _selectableSemester.add(givenSemester);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 16,
              right: 16,
              top: 12,
            ),
            child: Center(
              child: Text(
                'Tambah Semester',
                style: FontTheme.poppins14w700black(),
              ),
            ),
          ),
          Positioned(
            right: -15,
            top: -15,
            child: IconButton(
              onPressed: () => nav.pop(),
              icon: const Icon(
                Icons.close_rounded,
                size: 30,
                color: BaseColors.gray2,
              ),
            ),
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
      content: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    _selectableSemester.length,
                    (index) {
                      final semester = _selectableSemester[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: BaseColors.white,
                          boxShadow:
                              BoxShadowDecorator().defaultShadow(context),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: index != _selectableSemester.length - 1
                            ? const EdgeInsets.only(bottom: 20)
                            : null,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    !semester.contains('sp')
                                        ? 'Semester $semester'
                                        : 'SP ${semester.substring(3)}',
                                    style: FontTheme.poppins12w400black(),
                                  ),
                                ],
                              ),
                            ),
                            const WidthSpace(20),
                            Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(
                                horizontal: -3.5,
                                vertical: -3.5,
                              ),
                              splashRadius: 10,
                              activeColor: BaseColors.primaryColor,
                              value: _selectedSemester.contains(semester),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    _selectedSemester.add(semester);
                                  } else {
                                    _selectedSemester.remove(semester);
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
            child: PrimaryButton(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              backgroundColor: BaseColors.accentColor,
              text: 'Tambah Semester',
              onPressed: () => widget.onPressed(_selectedSemester),
            ),
          )
        ],
      ),
    );
  }
}
