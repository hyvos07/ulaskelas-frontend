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
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Tambah Semester',
                style: FontTheme.poppins16w700black(),
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
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                _selectableSemester.length,
                (index) {
                  return CheckboxListTile(
                    value:
                        _selectedSemester.contains(_selectableSemester[index]),
                    title: Text(
                      !_selectableSemester[index].contains('sp')
                          ? 'Semester ${_selectableSemester[index]}'
                          : 'Semester Pendek '
                              '${_selectableSemester[index].substring(3)}',
                      style: FontTheme.poppins14w400black(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _selectedSemester.add(_selectableSemester[index]);
                        } else {
                          _selectedSemester.remove(_selectableSemester[index]);
                        }
                      });
                    },
                    splashRadius: 10,
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: PrimaryButton(
            backgroundColor: BaseColors.accentColor,
            text: 'Tambah Semester',
            onPressed: () => widget.onPressed(_selectedSemester),
          ),
        )
      ],
    );
  }
}
