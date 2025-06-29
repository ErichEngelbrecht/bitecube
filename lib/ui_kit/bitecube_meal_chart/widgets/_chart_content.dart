part of 'bitecube_meal_chart.dart';

class _ChartContent extends StatelessWidget {
  const _ChartContent({
    required this.dividedMeals,
    required this.macroType,
    required this.maxMacroAmount,
    required this.periodOfDays,
  });

  final List<List<MealDTO>> dividedMeals;
  final MacroType? macroType;
  final PeriodOfDaysType periodOfDays;
  final double maxMacroAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            context.l10n.macros_intake,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.teal,
                ),
                Text(context.l10n.calories),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.grey,
                ),
                Text(context.l10n.protein),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.tealAccent,
                ),
                Text(context.l10n.calories),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),
                Text(context.l10n.fats),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 320,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(maxMacroAmount.toStringAsFixed(0))),
                  Expanded(
                    child: Text((maxMacroAmount * 3 / 4).toStringAsFixed(0)),
                  ),
                  Expanded(
                    child: Text((maxMacroAmount * 2 / 4).toStringAsFixed(0)),
                  ),
                  Expanded(
                    child: Text((maxMacroAmount * 1 / 4).toStringAsFixed(0)),
                  ),
                  const Text('0'),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(),
                          bottom: BorderSide(),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: dividedMeals
                            .map(
                              (mealGroup) => Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: _ChartBars(
                                          selectedMacroType: macroType,
                                          chartHeight: 300,
                                          maxAmount: maxMacroAmount,
                                          meals: mealGroup,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 1; i <= periodOfDays.splitAmount; i++)
                          Text(i.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
