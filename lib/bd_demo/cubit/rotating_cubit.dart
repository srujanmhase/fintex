import 'package:animationsdemo/bd_demo/rotating.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rotating_state.dart';

class RotatingCubit extends Cubit<RotatingState> {
  RotatingCubit()
      : super(
          Rotating(
            selections: const {
              0: SelectedOption.first,
              1: SelectedOption.second,
              2: SelectedOption.third,
              3: SelectedOption.fourth,
            },
            rotate: RotateOption.none,
          ),
        );

  void handleTap(int index, Map<int, SelectedOption>? selections) {
    var newMap = <int, SelectedOption>{};
    switch (index) {
      case 0:
        return;
      case 1:
        newMap = RotatingUtils.updatePositionCounterClockwise(selections!);
        return emit(
          Rotating(
            rotate: RotateOption.counterClockwiseNinety,
            selections: newMap,
          ),
        );
      case 2:
        newMap = RotatingUtils.updatePositionCounterClockwise(selections!);
        newMap = RotatingUtils.updatePositionCounterClockwise(newMap);
        return emit(
          Rotating(
            rotate: RotateOption.counterClockwiseOneEighty,
            selections: newMap,
          ),
        );
      case 3:
        newMap = RotatingUtils.updatePositionClockwise(selections!);
        return emit(
          Rotating(
            rotate: RotateOption.clockwiseNinety,
            selections: newMap,
          ),
        );
      default:
    }
  }
}
