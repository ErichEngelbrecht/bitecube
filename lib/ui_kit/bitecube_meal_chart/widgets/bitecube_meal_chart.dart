import 'package:bitecube/l10n/l10n.dart';
import 'package:bitecube/models/dto/meal_dto.dart';
import 'package:bitecube/models/enums/macro_type.dart';
import 'package:bitecube/models/enums/meal_type.dart';
import 'package:bitecube/models/enums/period_of_days_type.dart';
import 'package:bitecube/ui_kit/bitecube_drop_down_field/bitecube_drop_down_field.dart';
import 'package:bitecube/ui_kit/bitecube_meal_chart/utils/get_divided_meals.dart';
import 'package:bitecube/ui_kit/bitecube_meal_chart/utils/get_max_selected_macro_amount.dart';
import 'package:bitecube/ui_kit/bitecube_meal_chart/utils/get_most_popular_meal.dart';
import 'package:flutter/material.dart';

part '_chart_bars.dart';
part '_chart_content.dart';

class BitecubeChart extends StatefulWidget {
  const BitecubeChart({required this.context, required this.meals, super.key});

  final BuildContext context;
  final List<MealDTO> meals;

  @override
  State<BitecubeChart> createState() => _BitecubeChartState();
}

class _BitecubeChartState extends State<BitecubeChart> {
  MealType? mealType;
  PeriodOfDaysType? periodOfDays;
  MacroType? macroType;

  @override
  Widget build(BuildContext context) {
    final maxMacroAmount = getMaxSelectedMacroAmount(
      meals: widget.meals,
      macroType: macroType,
    );
    final dividedMeals = getDividedMeals(
      meals: widget.meals,
      periodOfDays: periodOfDays ?? PeriodOfDaysType.THREE_DAYS,
      mealType: mealType,
    );

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: BitecubeDropDownField(
                initialSelection: macroType?.title ?? 'All',
                entries: [
                  const DropdownMenuEntry(
                    value: 'All',
                    label: 'All',
                  ),
                  ...MacroType.values.map(
                    (type) => DropdownMenuEntry(
                      value: type.title,
                      label: type.title,
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'All') {
                    setState(() {
                      macroType = null;
                    });
                  } else if (value != null) {
                    setState(() {
                      macroType = MacroType.fromString(value);
                    });
                  }
                },
              ),
            ),
            Container(
              width: 16,
            ),
            Expanded(
              child: BitecubeDropDownField(
                initialSelection: mealType?.title ?? 'All',
                entries: [
                  const DropdownMenuEntry(value: 'All', label: 'All'),
                  ...MealType.values.map(
                    (type) => DropdownMenuEntry(
                      value: type.title,
                      label: type.title,
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'All') {
                    setState(() {
                      mealType = null;
                    });
                  } else if (value != null) {
                    setState(() {
                      mealType = MealType.fromString(value);
                    });
                  }
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Expanded(
                child: BitecubeDropDownField(
                  initialSelection:
                      periodOfDays?.title ?? PeriodOfDaysType.THREE_DAYS.title,
                  entries: PeriodOfDaysType.values
                      .map(
                        (type) => DropdownMenuEntry(
                          value: type.title,
                          label: type.title,
                        ),
                      )
                      .toList(),
                  onSelected: (value) {
                    if (value != null) {
                      setState(() {
                        periodOfDays = PeriodOfDaysType.fromString(value);
                      });
                    }
                  },
                ),
              ),
              Container(
                width: 16,
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _ChartContent(
            dividedMeals: dividedMeals,
            macroType: macroType,
            maxMacroAmount: maxMacroAmount,
            periodOfDays: periodOfDays ?? PeriodOfDaysType.THREE_DAYS,
          ),
        ),
        Text('${context.l10n.meals_added}: ${widget.meals.length}'),
        Text(
          '${context.l10n.favourite_meal}: ${getMostPopularMeal(widget.meals).title}',
        ),
      ],
    );
  }
}
