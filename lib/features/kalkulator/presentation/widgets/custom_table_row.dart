part of '_widgets.dart';

// STYLING INSTRUCTIONS
// 1. isGradient
//    => determines whether the text color should be gradient or not
//
// 2. (Gradient) customGradientColors
//               => specifies the colors to be used for the gradient
//    (Non-Gradient) componentStyle
//               => defines the styling from scratch
//
// 3. style
//    => applies globally
//    => can be overridden by customGradientColors & componentStyle

abstract class CustomTableRowComponentProp {
  int get flexRatio;
  String get text;
  bool? get isGradient;
  TextStyle? get componentStyle;
  List<Color>? get gradientColors;
  TextAlign? get textAlign;
}

class CustomTableRowComponent implements CustomTableRowComponentProp {
  @override
  final int flexRatio;
  @override
  final String text;
  @override
  final bool? isGradient;
  @override 
  final TextStyle? componentStyle;
  @override 
  List<Color>? gradientColors;
  @override
  TextAlign? textAlign;


  CustomTableRowComponent({
    required this.flexRatio, 
    required this.text,
    this.isGradient,
    this.componentStyle,
    this.gradientColors,
    this.textAlign,
  });
}

class CustomTableRow extends StatelessWidget {
  const CustomTableRow({
    required this.components, 
    this.style,
    super.key,
  });

  final List<CustomTableRowComponent> components;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'kucing meong',
      child: Row(
        children: List.generate(
          components.length,
          (index) {
            final component = components[index];
            return Expanded(
              flex: component.flexRatio,
              // ignore: use_if_null_to_convert_nulls_to_bools
              child: component.isGradient == true
                ? GradientText(
                    component.text, 
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: component.gradientColors 
                                ?? BaseColors.autoSystemColor,
                    ),
                    style: style ?? FontTheme.poppins12w600black(),
                    textAlign: index == components.length - 1 
                                && component.textAlign != null 
                      ? component.textAlign
                      : null,
                  )
                : Text(
                    component.text,
                    style: component.componentStyle
                            ?? style ?? FontTheme.poppins12w600black(),
                    textAlign: index == components.length - 1 
                                && component.textAlign != null 
                      ? component.textAlign
                      : null,
                  ),
            );
          },
        ),
      ),
    );
  }
}
