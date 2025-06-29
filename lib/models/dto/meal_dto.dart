import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_dto.freezed.dart';
part 'meal_dto.g.dart';

@Freezed(copyWith: true)
abstract class MealDTO with _$MealDTO {
  const factory MealDTO({
    required int id,
    required String mealType,
    required String mealTitle,
    required String mealDescription,
    required int quantity,
    required int unixTime,
    int? calories,
    int? protein,
    int? carbohydrates,
    int? fats,
  }) = _MealDTO;

  factory MealDTO.empty() => const MealDTO(
      id: 0,
      mealType: '',
      mealTitle: '',
      mealDescription: '',
      quantity: 0,
      unixTime: 0);

  factory MealDTO.fromJson(Map<String, Object?> json) =>
      _$MealDTOFromJson(json);
}
