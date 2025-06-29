import 'dart:math';

import 'package:bitecube/models/dto/meal_dto.dart';
import 'package:bitecube/models/enums/macro_type.dart';

double getMaxSelectedMacroAmount({
  required List<MealDTO> meals,
  MacroType? macroType,
}) {
  var maxMacroAmount = 0.0;
  for (final meal in meals) {
    if (macroType == null || macroType == MacroType.CALORIES) {
      maxMacroAmount = max(maxMacroAmount, meal.calories?.toDouble() ?? 0);
    }
    if (macroType == null || macroType == MacroType.PROTEIN) {
      maxMacroAmount = max(maxMacroAmount, meal.protein?.toDouble() ?? 0);
    }
    if (macroType == null || macroType == MacroType.CARBOHYDRATES) {
      maxMacroAmount = max(maxMacroAmount, meal.carbohydrates?.toDouble() ?? 0);
    }
    if (macroType == null || macroType == MacroType.FATS) {
      maxMacroAmount = max(maxMacroAmount, meal.fats?.toDouble() ?? 0);
    }
  }
  return maxMacroAmount;
}
