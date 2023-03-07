import 'package:animationsdemo/bd_demo/rotating.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

class BdHome extends StatefulWidget {
  const BdHome({super.key});

  @override
  State<BdHome> createState() => _BdHomeState();
}

class _BdHomeState extends State<BdHome> with TickerProviderStateMixin {
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _menuAnimation = Tween<double>(begin: 0, end: 190).animate(_menuController);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: AnimatedBuilder(
          animation: _menuController,
          builder: (context, child) => Stack(
            clipBehavior: Clip.none,
            children: [
              Scaffold(
                floatingActionButton: const FlameActionButton(),
                body: SingleChildScrollView(
                  child: AnimatedPadding(
                    padding: EdgeInsets.only(left: _menuAnimation.value),
                    duration: _menuController.value > 0
                        ? Duration.zero
                        : _menuController.duration!,
                    child: GestureDetector(
                      onTap: () =>
                          _menuController.status == AnimationStatus.completed
                              ? _menuController.reverse()
                              : null,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const Text('data'),
                              TextButton(
                                onPressed: () => _menuController.status ==
                                        AnimationStatus.completed
                                    ? _menuController.reverse()
                                    : _menuController.forward(),
                                child: const Text('open settings'),
                              ),
                              Container(
                                color: Colors.purple,
                                width: MediaQuery.of(context).size.width,
                                height: 600,
                                child: const RotatingBox(),
                              ),
                              Container(
                                color: Colors.red,
                                width: MediaQuery.of(context).size.width,
                                height: 600,
                              ),
                            ],
                          ),
                          if (_menuController.status ==
                              AnimationStatus.completed)
                            Positioned.fill(
                              child: Container(
                                color: Colors.transparent,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: _menuAnimation.value - 190,
                child: SizedBox(
                  width: 190,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 450,
                          width: 190,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 450,
                          width: 190,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlameActionButton extends StatefulWidget {
  const FlameActionButton({super.key});

  @override
  State<FlameActionButton> createState() => _FlameActionButtonState();
}

class _FlameActionButtonState extends State<FlameActionButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> a;
  late Animation<double> b;
  late Animation<double> expanded;
  late Animation<double> heroExpansion;
  late Animation<double> topMargin;
  late Animation<double> outline;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    a = Tween<double>(begin: 0, end: 70).animate(_controller);
    b = Tween<double>(begin: 0, end: 30).animate(_controller);
    expanded = Tween<double>(begin: 160, end: 100).animate(_controller);
    heroExpansion = Tween<double>(begin: 50, end: 110).animate(_controller);
    topMargin = Tween<double>(begin: 75, end: 50).animate(_controller);
    outline = Tween<double>(begin: 0, end: 76).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 200,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              left: 100,
              child: SizedBox(
                height: 200,
                width: 300,
                child: Align(
                  child: Flow(
                    delegate: FlameDelegate(a: a, b: b, expanded: expanded),
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () => print('obj'),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: 7,
            //   right: -45,
            //   child: Container(
            //     width: 200,
            //     height: 200,
            //     decoration: BoxDecoration(
            //       border: Border.all(),
            //       shape: BoxShape.circle,
            //     ),
            //   ),
            // ),
            Positioned(
              top: topMargin.value,
              right: 0,
              child: InkWell(
                onTap: () => _controller.status == AnimationStatus.completed
                    ? _controller.reverse()
                    : _controller.forward(),
                child: Container(
                  width: heroExpansion.value,
                  height: heroExpansion.value,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlameDelegate extends FlowDelegate {
  const FlameDelegate({
    required this.a,
    required this.b,
    required this.expanded,
  }) : super(
          repaint: a,
        );
  final Animation<double> a;
  final Animation<double> b;
  final Animation<double> expanded;

  @override
  void paintChildren(FlowPaintingContext context) {
    for (var i = 0; i < context.childCount; i++) {
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          expanded.value + calculateX(i),
          100 + calculateY(i),
          0,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints(
      maxHeight: 25,
      minHeight: 25,
      maxWidth: 25,
      minWidth: 25,
    );
  }

  double calculateX(int index) {
    switch (index) {
      case 0:
      case 3:
        return -b.value;
      case 1:
      case 2:
        return -a.value;

      default:
        return 0;
    }
  }

  double calculateY(int index) {
    switch (index) {
      case 0:
        return -a.value;
      case 1:
        return -b.value;
      case 2:
        return b.value;
      case 3:
        return a.value;

      default:
        return 0;
    }
  }
}
