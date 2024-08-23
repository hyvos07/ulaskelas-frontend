part of '_widgets.dart';

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({
    required this.child,
    this.position = const [
      Offset.zero,
      Offset(0, -0.1),
    ],
    this.reverse = false,
    this.duration = const Duration(seconds: 2),
    super.key,
  });

  final Widget? child;
  final List<Offset> position;
  final Duration duration;
  final bool reverse;

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: widget.reverse ? widget.position[1] : widget.position[0],
    end: widget.reverse ? widget.position[0] : widget.position[1],
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
