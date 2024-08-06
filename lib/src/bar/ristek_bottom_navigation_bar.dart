// Created by Muhamad Fauzi Ridwan on 07/11/21.

// ignore_for_file: deprecated_member_use

part of '_bar.dart';

/// A Ristek Custom Bottom Navigation Bar.
class NewRistekBotNavBar extends StatefulWidget {
  /// Creates A Ristek Bottom Navigation Bar.
  const NewRistekBotNavBar({
    required this.onTap, required this.items, super.key,
    this.initialActiveIndex = 0,
  });

  final Function(int index) onTap;
  final List<NewRistekBotNavItem> items;
  final int initialActiveIndex;

  @override
  _NewRistekBotNavBarState createState() => _NewRistekBotNavBarState();
}

class _NewRistekBotNavBarState extends State<NewRistekBotNavBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        boxShadow: BoxShadowDecorator().defaultShadow(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.items.map((e) {
          final isSelected =
              widget.items.indexOf(e) == widget.initialActiveIndex;
          return Expanded(
            child: InkWell(
              onTap: () => widget.onTap(widget.items.indexOf(e)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (e.icon != null)
                    Icon(
                      e.icon,
                      color: isSelected 
                        ? theme.colorScheme.primary : theme.disabledColor,
                      size: 24,
                    )
                  else if (e.svgIcon != null)
                    SvgPicture.asset(
                      e.svgIcon!,
                      color: isSelected 
                        ? theme.colorScheme.primary : theme.disabledColor,
                      width: 24,
                      height: 24,
                    ),
                  const HeightSpace(5),
                  Text(e.text.toString(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.caption?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w400,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.disabledColor,
                    ),
                  ),
                  const HeightSpace(5),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeInQuad,
                    height: 5,
                    width: isSelected ? 35 : 0,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}