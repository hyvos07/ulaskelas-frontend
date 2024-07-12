part of '_widgets.dart';

/// Creates A Button with Linear Gradient Color.
///
/// the either both of [text] and [child] cannot be null or null.
class GradientBorderButton extends StatelessWidget {
  const GradientBorderButton({
    super.key,
    this.child,
    this.text,
    this.onPressed,
    this.borderRadius,
    this.width,
    this.height,
    this.padding,
    this.gradient,
    this.borderColor,
    this.borderWidth,
    this.textStyle,
  })  : assert(text == null || child == null, 'One of them must be null.'),
        assert(child != null || text != null, 'One of them must not be null.');

  /// If null describe this button is disabled.
  ///
  /// Defaults to null.
  final VoidCallback? onPressed;

  /// Either [child] or [text] must not be null.
  ///
  /// Specify child for dynamic content.
  final Widget? child;

  /// Whether button has text content.
  final String? text;

  /// Text color.
  final TextStyle? textStyle;

  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  final double? borderRadius;

  /// if non-null, this box button will use specific height.
  final double? height;

  /// if non-null, this box button will use specific width.
  final double? width;

  final EdgeInsetsGeometry? padding;

  final Gradient? gradient;

  final Color? borderColor;

  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final borderRadiusFix = borderRadius ?? 6;
    final borderWidthFix = borderWidth ?? 1;
    return GhostButton(
      width: width,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadiusFix),
        ),
        child: Padding(
          padding: EdgeInsets.all(borderWidthFix),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(borderRadiusFix - borderWidthFix),
            ),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(8),
              child: Center(
                child: GradientText(
                  gradient: gradient!,
                  text ?? '',
                  style: textStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
