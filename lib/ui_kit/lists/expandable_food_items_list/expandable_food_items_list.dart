import 'package:bitecube/l10n/l10n.dart';
import 'package:bitecube/models/dto/meal_dto.dart';
import 'package:bitecube/models/enums/meal_type.dart';
import 'package:bitecube/models/extensions/int.dart';
import 'package:bitecube/ui_kit/bottom_sheets/bitecube_meal_bottom_sheet.dart';
import 'package:bitecube/ui_kit/buttons/bitecube_button.dart';
import 'package:flutter/material.dart';

part '_meal_details.dart';

class ExpandableFoodItemsList extends StatefulWidget {
  const ExpandableFoodItemsList({
    required this.title,
    required this.meal,
    super.key,
  });

  final MealDTO meal;
  final String title;

  @override
  State<ExpandableFoodItemsList> createState() =>
      _ExpandableFoodItemsListState();
}

class _ExpandableFoodItemsListState extends State<ExpandableFoodItemsList> {
  bool showItems = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showItems = !showItems;
            });
          },
          child: Container(
            padding: const EdgeInsets.only(left: 8),
            color: theme.primaryColor,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                AnimatedRotation(
                  turns: showItems && widget.meal.id != 0 ? 0 : 1 / 2,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: showItems && widget.meal.id != 0 ? 200 : 0,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _MealDetails(widget.meal.id != 0 ? widget.meal : null),
            ],
          ),
        ),
        Container(
          height: 50,
          width: double.infinity,
          color: theme.colorScheme.inversePrimary,
          child: Center(
            child: BitecubeButton(
              child: Text(
                widget.meal.id != 0
                    ? context.l10n.edit_meal
                    : context.l10n.add_meal,
              ),
              onPressed: () {
                showBitecubeMealBottomSheet(
                  context: context,
                  meal: widget.meal,
                  mealType: MealType.fromString(
                    widget.title,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
