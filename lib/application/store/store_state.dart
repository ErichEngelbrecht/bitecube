part of 'store_bloc.dart';

@freezed
abstract class StoreState with _$StoreState {
  const factory StoreState({
    required List<MealDTO> meals,
    required DateTime date,
    @Default(true) bool isLoading,
    Exception? failure,
  }) = _StoreState;

  factory StoreState.initial() => StoreState(
        meals: [],
        date: DateTime.now(),
      );
}
