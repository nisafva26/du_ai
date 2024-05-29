

import 'package:flutter/material.dart';

class CustomTicketWidget extends StatefulWidget {
  const CustomTicketWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    this.padding,
    this.margin,
    this.color = Colors.white,
    this.isCornerRounded = false,
    this.shadow,
    required this.circleHeightFromTop
  }) : super(key: key);

  final double width;
  final double height;
  final Widget child;
  final Color color;
  final bool isCornerRounded;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadow;
  final double circleHeightFromTop;

  @override
  _CustomTicketWidgetState createState() => _CustomTicketWidgetState();
}

class _CustomTicketWidgetState extends State<CustomTicketWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(circleHeightFromTop: widget.circleHeightFromTop),
      child: AnimatedContainer(
        child: widget.child,
        duration: const Duration(seconds: 0),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
          boxShadow: widget.shadow,
          color: widget.color,
          borderRadius: widget.isCornerRounded ? BorderRadius.circular(12.0) : BorderRadius.circular(0.0),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double circleHeightFromTop;

  TicketClipper({required this.circleHeightFromTop});

  
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(Rect.fromCircle(center: Offset(0.0, circleHeightFromTop), radius: 15.0));
    path.addOval(Rect.fromCircle(center: Offset(size.width, circleHeightFromTop), radius: 15.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}