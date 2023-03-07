import 'dart:math' as math;

import 'package:animationsdemo/bd_demo/cubit/rotating_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RotatingUtils {
  static Map<int, SelectedOption> updatePositionCounterClockwise(
    Map<int, SelectedOption> old,
  ) {
    var newMapUp = <int, SelectedOption>{};
    for (var i = 0; i < old.length; i++) {
      if (i != old.length - 1) newMapUp[i] = old[i + 1] ?? SelectedOption.first;
      if (i == old.length - 1) newMapUp[i] = old[0] ?? SelectedOption.first;
    }
    return newMapUp;
  }

  static Map<int, SelectedOption> updatePositionClockwise(
      Map<int, SelectedOption> old) {
    var newMapDown = <int, SelectedOption>{};
    for (var i = 0; i < old.length; i++) {
      if (i == 0) newMapDown[i] = old[old.length - 1] ?? SelectedOption.first;
      if (i != 0) newMapDown[i] = old[i - 1] ?? SelectedOption.first;
    }
    return newMapDown;
  }
}

class RotatingBox extends StatefulWidget {
  const RotatingBox({super.key});

  @override
  State<RotatingBox> createState() => _RotatingBoxState();
}

class _RotatingBoxState extends State<RotatingBox>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Tween<double> _tween;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _tween = Tween<double>(begin: 0, end: 0);
    _animation = _tween.animate(
      _controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RotatingCubit(),
      child: Builder(builder: (context) {
        var current = context.watch<RotatingCubit>().state;
        return Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              (current is Rotating) ? current.selections[0].toString() : 'none',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            BlocConsumer<RotatingCubit, RotatingState>(
              listener: (context, state) async {
                if (state is Rotating) {
                  switch (state.rotate) {
                    case RotateOption.clockwiseNinety:
                      _tween.begin = _tween.end;
                      _tween.end = _tween.end! + (math.pi / 2);
                      _controller.reset();
                      await _controller.forward();
                      break;
                    case RotateOption.clockwiseOneEighty:
                      break;
                    case RotateOption.counterClockwiseNinety:
                      _tween.begin = _tween.end;
                      _tween.end = _tween.end! - (math.pi / 2);
                      _controller.reset();
                      await _controller.forward();
                      break;
                    case RotateOption.counterClockwiseOneEighty:
                      _tween.begin = _tween.end;
                      _tween.end = _tween.end! - math.pi;
                      _controller.reset();
                      await _controller.forward();
                      break;
                    default:
                  }
                }
              },
              builder: (context, state) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.amber,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 80,
                              child: GestureDetector(
                                onTap: () {
                                  context.read<RotatingCubit>().handleTap(
                                        (current is Rotating)
                                            ? current.selections.values
                                                .toList()
                                                .indexOf(SelectedOption.first)
                                            : 0,
                                        (current is Rotating)
                                            ? current.selections
                                            : null,
                                      );
                                },
                                child: const Text('first'),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  context.read<RotatingCubit>().handleTap(
                                        (current is Rotating)
                                            ? current.selections.values
                                                .toList()
                                                .indexOf(SelectedOption.second)
                                            : 0,
                                        (current is Rotating)
                                            ? current.selections
                                            : null,
                                      );
                                },
                                child: const Text('second'),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 80,
                              child: GestureDetector(
                                onTap: () {
                                  context.read<RotatingCubit>().handleTap(
                                        (current is Rotating)
                                            ? current.selections.values
                                                .toList()
                                                .indexOf(SelectedOption.third)
                                            : 0,
                                        (current is Rotating)
                                            ? current.selections
                                            : null,
                                      );
                                },
                                child: const Text('third'),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              left: 0,
                              child: GestureDetector(
                                onTap: () {
                                  context.read<RotatingCubit>().handleTap(
                                        (current is Rotating)
                                            ? current.selections.values
                                                .toList()
                                                .indexOf(SelectedOption.fourth)
                                            : 0,
                                        (current is Rotating)
                                            ? current.selections
                                            : null,
                                      );
                                },
                                child: const Text('fourth'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
