import 'package:bitecube/models/dto/meal_dto.dart';
import 'package:bitecube/models/enums/meal_type.dart';

MealType getMostPopularMeal(List<MealDTO> meals) {
  final breakfastAmount = meals
      .where(
        (meal) => MealType.fromString(meal.mealType) == MealType.BREAKFAST,
      )
      .length;
  final lunchAmount = meals
      .where(
        (meal) => MealType.fromString(meal.mealType) == MealType.LUNCH,
      )
      .length;
  final dinnerAmount = meals
      .where(
        (meal) => MealType.fromString(meal.mealType) == MealType.DINNER,
      )
      .length;
  final snackAmount = meals
      .where(
        (meal) => MealType.fromString(meal.mealType) == MealType.SNACK,
      )
      .length;

  var popularMealType = MealType.BREAKFAST;
  var popularMealAmount = breakfastAmount;
  if (lunchAmount > popularMealAmount) {
    popularMealType = MealType.LUNCH;
    popularMealAmount = lunchAmount;
  }
  if (dinnerAmount > popularMealAmount) {
    popularMealType = MealType.DINNER;
    popularMealAmount = dinnerAmount;
  }
  if (snackAmount > popularMealAmount) {
    popularMealType = MealType.SNACK;
    popularMealAmount = snackAmount;
  }

  return popularMealType;
}
