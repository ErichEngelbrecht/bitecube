part of 'account_bloc.dart';

@freezed
abstract class AccountState with _$AccountState {
  const factory AccountState({
    required String email,
    required String name,
    @Default(false) bool isLoading,
    Exception? failure,
  }) = _AccountState;

  factory AccountState.initial() => const AccountState(
        email: '',
        name: '',
      );
}
