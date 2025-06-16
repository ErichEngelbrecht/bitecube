part of 'bitecube_meal_chart.dart';

class _ChartBars extends StatelessWidget {
  const _ChartBars({
    required this.chartHeight,
    required this.maxAmount,
    required this.meals,
    this.selectedMacroType,
  });

  final MacroType? selectedMacroType;
  final double chartHeight;
  final double maxAmount;
  final List<MealDTO> meals;

  @override
  Widget build(BuildContext context) {
    final calorieAmount = addAmounts(meals, MacroType.CALORIES);
    final proteinAmount = addAmounts(meals, MacroType.PROTEIN);
    final carbohydratesAmount = addAmounts(meals, MacroType.CARBOHYDRATES);
    final fatsAmount = addAmounts(meals, MacroType.FATS);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (selectedMacroType == null ||
            selectedMacroType == MacroType.CALORIES)
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: chartHeight,
              ),
              height: calorieAmount / maxAmount * chartHeight,
              color: Colors.teal,
            ),
          ),
        if (selectedMacroType == null || selectedMacroType == MacroType.PROTEIN)
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: chartHeight,
              ),
              height: proteinAmount / maxAmount * chartHeight,
              color: Colors.grey,
            ),
          ),
        if (selectedMacroType == null ||
            selectedMacroType == MacroType.CARBOHYDRATES)
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: chartHeight,
              ),
              height: carbohydratesAmount / maxAmount * chartHeight,
              color: Colors.tealAccent,
            ),
          ),
        if (selectedMacroType == null || selectedMacroType == MacroType.FATS)
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: chartHeight,
              ),
              height: fatsAmount / maxAmount * chartHeight,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}

double addAmounts(List<MealDTO> meals, MacroType macroType) {
  double totalAmount = 0;

  switch (macroType) {
    case MacroType.CARBOHYDRATES:
      for (final meal in meals) {
        totalAmount += meal.carbohydrates ?? 0;
      }

    case MacroType.PROTEIN:
      for (final meal in meals) {
        totalAmount += meal.protein ?? 0;
      }

    case MacroType.FATS:
      for (final meal in meals) {
        totalAmount += meal.fats ?? 0;
      }

    case MacroType.CALORIES:
      for (final meal in meals) {
        totalAmount += meal.calories ?? 0;
      }
  }

  return totalAmount;
}
