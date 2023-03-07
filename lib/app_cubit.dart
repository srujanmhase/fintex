import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_cubit.freezed.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          const AppState(
            isRecentsActive: false,
            isSendActive: false,
            isTransacting: false,
            isSending: false,
            isSent: false,
          ),
        );

  Future<void> send() async {
    emit(state.copyWith(isTransacting: true, isSending: true));
    await Future.delayed(const Duration(seconds: 2), () {});
    emit(state.copyWith(isSending: false, isSent: true));
    await Future.delayed(const Duration(seconds: 1), () {});
    emit(state.copyWith(isTransacting: false, isSent: false));
  }

  void sendToggle() {
    emit(state.copyWith(isSendActive: !state.isSendActive));
  }

  void recentToggle() {
    emit(state.copyWith(isRecentsActive: !state.isRecentsActive));
  }
}
