part of 'expandable_food_items_list.dart';

class _MealDetails extends StatelessWidget {
  const _MealDetails(this.meal);

  final MealDTO? meal;

  @override
  Widget build(BuildContext context) {
    return meal != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: _mealDetailsText(meal!.mealTitle),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _mealDetailsText(meal!.mealDescription),
              ),
              Row(
                children: [
                  Expanded(
                    child: _mealDetailsText(
                      '${context.l10n.calories}: ${meal!.calories ?? 0} kcal',
                    ),
                  ),
                  Expanded(
                    child: _mealDetailsText(
                      '${context.l10n.protein}: ${meal!.protein ?? 0}g',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _mealDetailsText(
                      '${context.l10n.carbohydrates}: ${meal!.carbohydrates ?? 0}g',
                    ),
                  ),
                  Expanded(
                    child: _mealDetailsText(
                      '${context.l10n.fats}: ${meal!.fats ?? 0}g',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: _mealDetailsText(
                  '${context.l10n.time_of_day}: ${meal!.unixTime.toTimeOfDay() ?? '00:00'}',
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

Text _mealDetailsText(
  String text,
) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18,
    ),
  );
}
