part of 'store_bloc.dart';

@freezed
class StoreEvent with _$StoreEvent {
  const factory StoreEvent.getMeals() = GetMeals;
  const factory StoreEvent.setMeal(MealDTO meal) = SetMeal;
  const factory StoreEvent.onChangeDate(DateTime date) = OnChangeDate;
}
