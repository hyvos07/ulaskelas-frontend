part of '_widgets.dart';

/// Creates A Text with Linear Gradient Color.
///
/// Credits to [NearHuscarl](https://stackoverflow.com/a/59360135/15691118).
class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    super.key,
    this.style,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style, textAlign: textAlign,),
    );
  }
}
