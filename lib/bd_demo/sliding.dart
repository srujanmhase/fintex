import 'package:flutter/material.dart';

class SlidingCircle extends StatefulWidget {
  const SlidingCircle({super.key});

  @override
  State<SlidingCircle> createState() => _SlidingCircleState();
}

class _SlidingCircleState extends State<SlidingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Tween<double> _Xtween;
  late Tween<double> _Ytween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
