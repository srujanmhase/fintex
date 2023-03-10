import 'package:flutter/material.dart';

class DynamicIslandWidget extends StatefulWidget {
  const DynamicIslandWidget({
    super.key,
    required this.width,
    required this.controller,
    required this.child,
  });
  final double width;
  final AnimationController controller;
  final Widget child;
  @override
  State<DynamicIslandWidget> createState() => _DynamicIslandWidgetState();
}

class _DynamicIslandWidgetState extends State<DynamicIslandWidget>
    with TickerProviderStateMixin {
  late Animation<double> _width;
  late Animation<double> _height;

  @override
  void initState() {
    super.initState();

    final _curve = CurvedAnimation(
      parent: widget.controller,
      curve: Curves.easeInOutQuint,
    );
    _width = Tween<double>(
      begin: 0,
      end: widget.width,
    ).animate(_curve);
    _height = Tween<double>(begin: 0, end: 100).animate(_curve);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return SizedBox(
          height: _height.value,
          width: _width.value,
          child: child,
        );
      },
      child: InkWell(
        onTap: () async {
          if (widget.controller.status == AnimationStatus.completed) {
            await widget.controller.reverse();
          }
        },
        child: widget.child,
      ),
    );
  }
}
