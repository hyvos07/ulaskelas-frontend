part of '_widgets.dart';

class ExpansionCard extends StatefulWidget {
  // Semester semester => list of course dan semester ke berapa
  const ExpansionCard({
    super.key, 
    this.title,
    this.children,
    this.onCheckboxChanged,
  });

  final String? title;
  final List<String>? children;
  final void Function(bool isChecked)? onCheckboxChanged;

  @override
  State<ExpansionCard> createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  bool _isExpanded = false;
  bool? _isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile(
        title: Row(
          children: [
            const SizedBox(width: 5,),
            Icon(
              _isExpanded 
                ? Icons.arrow_drop_down_rounded 
                : Icons.arrow_drop_up_rounded, 
              size: 30,
              color: BaseColors.mineShaft.withOpacity(0.78),
            ),
            Text(
              widget.title!, 
              style: FontTheme.poppins12w500black(),
            ),
          ],
        ),
        tilePadding: EdgeInsets.zero,
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
        trailing: Transform.scale(
          scale: 0.8,
          child: Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.5),
            ),
            activeColor: BaseColors.accentColor,
            onChanged: (value) {
              setState(() {
                _isCheck = value;
                widget.onCheckboxChanged!(_isCheck!);
              });
            },
            value: _isCheck,
          ),
        ),
        childrenPadding: const EdgeInsets.only(left: 17.5, bottom: 10),
        children: widget.children!.map((e) {
          return Row(
            children: [
              Icon(
                Icons.fiber_manual_record, 
                size: 5,
                color: BaseColors.mineShaft.withOpacity(0.78),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  e,
                  style: FontTheme.poppins10w400black()
                      .copyWith(
                        color: BaseColors.mineShaft.withOpacity(0.78),
                      ),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
