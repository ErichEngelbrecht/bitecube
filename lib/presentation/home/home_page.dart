import 'package:auto_route/auto_route.dart';
import 'package:bitecube/app/view/router.gr.dart';
import 'package:bitecube/application/store/store_bloc.dart';
import 'package:bitecube/l10n/l10n.dart';
import 'package:bitecube/models/dto/meal_dto.dart';
import 'package:bitecube/models/enums/meal_type.dart';
import 'package:bitecube/models/extensions/int.dart';
import 'package:bitecube/presentation/home/utils/is_same_day.dart';
import 'package:bitecube/ui_kit/date_picker/bitecube_date_picker.dart';
import 'package:bitecube/ui_kit/lists/expandable_food_items_list/expandable_food_items_list.dart';
import 'package:bitecube/ui_kit/scaffold/bitecube_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StoreBloc>().add(const StoreEvent.getMeals());
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) => BitecubeScaffold(
        title: context.l10n.homeAppBarTitle,
        leadingWidth: 110,
        leading: BitecubeDatePicker(
          selectedDate: state.date,
          onChange: (date) {
            context.read<StoreBloc>().add(StoreEvent.onChangeDate(date));
          },
        ),
        actions: [
          IconButton(
            onPressed: () => context.router.push(const StatisticsPageRoute()),
            icon: const Icon(Icons.insert_chart),
          ),
          IconButton(
            onPressed: () => context.router.push(const ProfilePageRoute()),
            icon: const Icon(Icons.account_circle),
          ),
        ],
        body: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ExpandableFoodItemsList(
                      meal: state.meals.firstWhere(
                        (meal) =>
                            MealType.BREAKFAST ==
                                MealType.fromString(meal.mealType) &&
                            isSameDate(
                              meal.unixTime.toDateTime(),
                              state.date,
                            ),
                        orElse: MealDTO.empty,
                      ),
                      title: MealType.BREAKFAST.title,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ExpandableFoodItemsList(
                      meal: state.meals.firstWhere(
                        (meal) =>
                            MealType.LUNCH ==
                                MealType.fromString(meal.mealType) &&
                            isSameDate(
                              meal.unixTime.toDateTime(),
                              state.date,
                            ),
                        orElse: MealDTO.empty,
                      ),
                      title: MealType.LUNCH.title,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ExpandableFoodItemsList(
                      meal: state.meals.firstWhere(
                        (meal) =>
                            MealType.DINNER ==
                                MealType.fromString(meal.mealType) &&
                            isSameDate(
                              meal.unixTime.toDateTime(),
                              state.date,
                            ),
                        orElse: MealDTO.empty,
                      ),
                      title: MealType.DINNER.title,
                    ),
                  ),
                  ExpandableFoodItemsList(
                    meal: state.meals.firstWhere(
                      (meal) =>
                          MealType.SNACK ==
                              MealType.fromString(meal.mealType) &&
                          isSameDate(
                            meal.unixTime.toDateTime(),
                            state.date,
                          ),
                      orElse: MealDTO.empty,
                    ),
                    title: MealType.SNACK.title,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
