part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required bool isTransacting,
    required bool isSending,
    required bool isSent,
    required bool isSendActive,
    required bool isRecentsActive,
  }) = _AppState;
}
