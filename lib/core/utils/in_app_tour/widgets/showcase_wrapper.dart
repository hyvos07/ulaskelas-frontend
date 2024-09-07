part of '_widgets.dart';

/// Showcase.withWidget Replacement.
class ShowcaseWrapper extends StatelessWidget {
  const ShowcaseWrapper({
    required this.showcaseKey,
    required this.child,
    required this.container,
    this.overlayColor,
    this.overlayOpacity,
    this.targetPadding,
    this.targetBorderRadius,
    this.blurValue,
    this.height,
    this.width,
    this.disposeOnTap,
    this.disableBarrierInteraction,
    this.disableMovingAnimation,
    this.onTargetClick,
    this.tooltipPosition,
    super.key,
  });

  final GlobalKey showcaseKey;
  final Widget child;
  final Widget container;
  final Color? overlayColor;
  final double? overlayOpacity;
  final EdgeInsets? targetPadding;
  final BorderRadius? targetBorderRadius;
  final double? blurValue;
  final double? height;
  final double? width;
  final bool? disposeOnTap;
  final bool? disableBarrierInteraction;
  final bool? disableMovingAnimation;
  final VoidCallback? onTargetClick;
  final TooltipPosition? tooltipPosition;

  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(
      key: showcaseKey,
      tooltipPosition: tooltipPosition,
      overlayColor: overlayColor ?? BaseColors.neutral100,
      overlayOpacity: overlayOpacity ?? 0.5,
      targetPadding: targetPadding ?? const EdgeInsets.all(10),
      targetBorderRadius: targetBorderRadius,
      blurValue: blurValue ?? 1,
      height: height ?? 0,
      width: width ?? MediaQuery.of(context).size.width,
      disposeOnTap: disposeOnTap ?? false,
      disableBarrierInteraction: disableBarrierInteraction ?? true,
      disableMovingAnimation: disableMovingAnimation ?? true,
      onTargetClick: onTargetClick ?? () {},
      container: container,
      child: child,
    );
  }
}
