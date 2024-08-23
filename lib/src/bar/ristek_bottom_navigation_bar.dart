// Created by Muhamad Fauzi Ridwan on 07/11/21.

// ignore_for_file: deprecated_member_use

part of '_bar.dart';

/// A Ristek Custom Bottom Navigation Bar.
class NewRistekBotNavBar extends StatefulWidget {
  /// Creates A Ristek Bottom Navigation Bar.
  const NewRistekBotNavBar({
    required this.onTap,
    required this.items,
    super.key,
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
    final iconSize = 22.0;
    final theme = Theme.of(context);
    navbarController = widget.onTap;

    return Container(
      padding: const EdgeInsets.fromLTRB(7, 12, 7, 0),
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
              child: Showcase.withWidget(
                key: _decideKey(e.text.toString()),
                overlayColor: BaseColors.neutral100,
                overlayOpacity: 0.5,
                targetPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: e.text.toString() == 'Tanya Teman' ? 10 : 0,
                ),
                blurValue: 1,
                height: 600,
                width: MediaQuery.of(context).size.width,
                disposeOnTap: false,
                disableBarrierInteraction: true,
                disableMovingAnimation: true,
                onTargetClick: () {
                  ShowCaseWidget.of(context).dismiss();
                  widget.onTap(widget.items.indexOf(e));
                },
                container: _decideContainer(e.text.toString()),
                child: Container(
                  decoration: const BoxDecoration(
                    color: BaseColors.transparent,
                  ),
                  constraints: const BoxConstraints(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (e.icon != null)
                        Icon(
                          e.icon,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.disabledColor,
                          size: iconSize,
                        )
                      else if (e.svgIcon != null)
                        SvgPicture.asset(
                          e.svgIcon!,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.disabledColor,
                          width: iconSize,
                          height: iconSize,
                        ),
                      const HeightSpace(5),
                      Text(
                        e.text.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: theme.textTheme.caption?.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.w400,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.disabledColor,
                          fontSize: 10,
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
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  GlobalKey _decideKey(String text) {
    switch (text) {
      case 'Matkul':
        return inAppTourKeys.navbarMatkul;
      case 'Tanya Teman':
        return inAppTourKeys.navbarTanyaTeman;
      case 'Kalkulator':
        return inAppTourKeys.navbarCalc;
      case 'Profil':
        return inAppTourKeys.navbarProfile;
      default:
        return GlobalKey();
    }
  }

  Widget _decideContainer(String text) {
    switch (text) {
      case 'Matkul':
        return navbarMatkulShowcase(text, context);
      case 'Tanya Teman':
        return navbarTanyaTemanShowcase(text, context);
      case 'Kalkulator':
        return navbarCalcShowcase(text, context);
      case 'Profil':
        return navbarProfileShowcase(text, context);
      default:
        return Container();
    }
  }
}
