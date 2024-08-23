part of '_widgets.dart';

class ExpansionCard extends StatefulWidget {
  // Semester semester => list of course dan semester ke berapa
  const ExpansionCard({
    super.key,
    this.title,
    this.children,
    this.forShowcase = false,
    this.onCheckboxChanged,
  });

  final String? title;
  final List<String>? children;
  final bool forShowcase;
  final void Function(bool isChecked)? onCheckboxChanged;

  @override
  State<ExpansionCard> createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  bool _isExpanded = false;
  bool? _isCheck = false;
  bool _forShowcase = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 13, left: 16, right: 16, top: 2.5),
      child: ListTileTheme(
        dense: true,
        horizontalTitleGap: 0.0,
        minLeadingWidth: 0,
        child: ExpansionTile(
          initiallyExpanded: widget.forShowcase,
          title: Row(
            children: [
              const WidthSpace(5),
              Icon(
                _isExpanded || (widget.forShowcase && _forShowcase)
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                size: 30,
                color: BaseColors.mineShaft.withOpacity(0.6),
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
              _forShowcase = value;
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
                  if (!widget.forShowcase) {
                    _isCheck = value;
                    widget.onCheckboxChanged!(_isCheck!);
                  }
                });
              },
              value: _isCheck! || widget.forShowcase,
            ),
          ),
          childrenPadding: const EdgeInsets.only(
            left: 17.5,
            bottom: 10,
            right: 17,
          ),
          children: widget.children!.map((e) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5.5),
                  child: Icon(
                    Icons.fiber_manual_record,
                    size: 5,
                    color: BaseColors.mineShaft.withOpacity(0.78),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    e,
                    style: FontTheme.poppins10w400black().copyWith(
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
      ),
    );
  }
}
