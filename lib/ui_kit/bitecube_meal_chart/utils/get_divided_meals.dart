import 'package:bitecube/models/dto/meal_dto.dart';
import 'package:bitecube/models/enums/meal_type.dart';
import 'package:bitecube/models/enums/period_of_days_type.dart';
import 'package:bitecube/models/extensions/date_time.dart';
import 'package:bitecube/models/extensions/int.dart';

List<List<MealDTO>> getDividedMeals({
  required List<MealDTO> meals,
  required PeriodOfDaysType periodOfDays,
  required MealType? mealType,
}) {
  final dividedMeals = <List<MealDTO>>[];
  final dateTimeNow = DateTime.now();

  switch (periodOfDays) {
    case PeriodOfDaysType.WEEK:
      final mealsInPeriod = meals.where(
        (meal) =>
            meal.unixTime >
            dateTimeNow
                .copyWith(
                  hour: 0,
                  minute: 0,
                )
                .add(
                  const Duration(days: -6),
                )
                .toUnixTime(),
      );
      for (var i = periodOfDays.days - 1; i >= 0; i--) {
        dividedMeals.add(
          mealsInPeriod
              .where(
                (meal) =>
                    dateTimeNow.day ==
                        meal.unixTime
                            .toDateTime()
                            ?.add(Duration(days: i))
                            .day &&
                    (mealType == null ||
                        MealType.fromString(meal.mealType) == mealType),
              )
              .toList(),
        );
      }

    case PeriodOfDaysType.FOUR_WEEKS:
      final mealsInPeriod = meals.where(
        (meal) =>
            meal.unixTime >
            dateTimeNow
                .copyWith(
                  hour: 0,
                  minute: 0,
                )
                .add(
                  const Duration(days: -29),
                )
                .toUnixTime(),
      );
      for (var i = periodOfDays.days - 1; i >= 0; i -= 7) {
        dividedMeals.add(
          mealsInPeriod
              .where(
                (meal) =>
                    dateTimeNow
                            .copyWith(hour: 0, minute: 0)
                            .add(Duration(days: -i + 7))
                            .toUnixTime() >
                        meal.unixTime &&
                    meal.unixTime >
                        meal.unixTime
                            .toDateTime()!
                            .add(Duration(days: -i))
                            .toUnixTime() &&
                    (mealType == null ||
                        MealType.fromString(meal.mealType) == mealType),
              )
              .toList(),
        );
      }

    case PeriodOfDaysType.THREE_DAYS:
      final mealsInPeriod = meals.where(
        (meal) =>
            meal.unixTime >
            dateTimeNow
                .copyWith(
                  hour: 0,
                  minute: 0,
                )
                .add(
                  const Duration(days: -2),
                )
                .toUnixTime(),
      );
      for (var i = periodOfDays.days; i > 0; i--) {
        dividedMeals.add(
          mealsInPeriod
              .where(
                (meal) =>
                    dateTimeNow.day ==
                        meal.unixTime
                            .toDateTime()
                            ?.add(Duration(days: i))
                            .day &&
                    (mealType == null ||
                        MealType.fromString(meal.mealType) == mealType),
              )
              .toList(),
        );
      }
  }
  return dividedMeals;
}
