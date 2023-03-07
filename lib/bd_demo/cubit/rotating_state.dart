part of 'rotating_cubit.dart';

@immutable
abstract class RotatingState {}

class Rotating implements RotatingState {
  Rotating({required this.rotate, required this.selections});
  final RotateOption rotate;
  final Map<int, SelectedOption> selections;

  RotateOption option() => rotate;
}

enum SelectedOption {
  first,
  second,
  third,
  fourth,
}

enum RotateOption {
  none,
  clockwiseNinety,
  clockwiseOneEighty,
  counterClockwiseNinety,
  counterClockwiseOneEighty,
}
