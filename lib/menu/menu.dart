import 'package:flutter/material.dart';

class DynamicIslandWidget extends StatefulWidget {
  const DynamicIslandWidget({
    super.key,
    required this.width,
    required this.controller,
  });
  final double width;
  final AnimationController controller;
  @override
  State<DynamicIslandWidget> createState() => _DynamicIslandWidgetState();
}

class _DynamicIslandWidgetState extends State<DynamicIslandWidget>
    with TickerProviderStateMixin {
  bool _isChildVisible = false;
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
    _height = Tween<double>(begin: 0, end: 150).animate(_curve);
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
        onLongPress: () async {
          await widget.controller.forward();
        },
        onTap: () async {
          if (widget.controller.status == AnimationStatus.completed) {
            await widget.controller.reverse();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
