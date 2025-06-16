part of 'account_bloc.dart';

@freezed
class AccountEvent with _$AccountEvent {
  const factory AccountEvent.onLogIn({
    required String email,
    required String password,
  }) = OnLogIn;
  const factory AccountEvent.onSignUp({
    required String email,
    required String password,
    required String name,
  }) = OnSignUp;
  const factory AccountEvent.onLogOut() = OnLogOut;
}
