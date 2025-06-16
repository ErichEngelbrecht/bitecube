import 'package:auto_route/auto_route.dart';
import 'package:bitecube/application/store/store_bloc.dart';
import 'package:bitecube/l10n/l10n.dart';
import 'package:bitecube/models/dto/meal_dto.dart';
import 'package:bitecube/models/enums/meal_type.dart';
import 'package:bitecube/models/extensions/date_time.dart';
import 'package:bitecube/models/extensions/int.dart';
import 'package:bitecube/ui_kit/bitecube_drop_down_field/bitecube_drop_down_field.dart';
import 'package:bitecube/ui_kit/bitecube_time_picker/bitecube_time_picker.dart';
import 'package:bitecube/ui_kit/snack_bar/bitecube_snack_bar.dart';
import 'package:bitecube/ui_kit/text_fields/bitecube_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showBitecubeMealBottomSheet({
  required BuildContext context,
  required MealType mealType,
  required MealDTO meal,
}) {
  Scaffold.of(context).showBottomSheet(
    (BuildContext context) => DraggableScrollableSheet(
      initialChildSize: 1,
      builder: (context, controller) => _MealBottomSheet(
        meal.id != 0 ? meal : null,
        mealType,
      ),
    ),
    showDragHandle: true,
  );
}

class _MealBottomSheet extends StatefulWidget {
  const _MealBottomSheet(this.meal, this.defaultMealType);

  final MealDTO? meal;
  final MealType defaultMealType;

  @override
  State<_MealBottomSheet> createState() => _MealBottomSheetState();
}

class _MealBottomSheetState extends State<_MealBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  int id = 0;
  String mealTitle = '';
  String mealDescription = '';
  String mealType = '';
  int calories = 0;
  int carbohydrates = 0;
  int protein = 0;
  int fats = 0;
  int quantity = 0;
  int unixTime = 0;

  @override
  void initState() {
    final timeNow = DateTime.now().toUnixTime();

    id = widget.meal?.id ?? timeNow;
    mealTitle = widget.meal?.mealTitle ?? '';
    mealDescription = widget.meal?.mealDescription ?? '';
    mealType = widget.defaultMealType.title;
    calories = widget.meal?.calories ?? 0;
    carbohydrates = widget.meal?.carbohydrates ?? 0;
    protein = widget.meal?.protein ?? 0;
    fats = widget.meal?.fats ?? 0;
    quantity = widget.meal?.quantity ?? 1;
    unixTime = widget.meal?.unixTime ?? timeNow;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreBloc, StoreState>(
      listener: (context, state) {
        if (!state.isLoading && state.failure == null) {
          context.router.maybePop();
        }
      },
      listenWhen: (oldState, newState) {
        return oldState.isLoading == true && newState.isLoading == false;
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  _padBottom(
                    BitecubeTextField(
                      onChanged: (value) {
                        mealTitle = value;
                      },
                      maxLength: 100,
                      label: context.l10n.title,
                      controller: TextEditingController(text: mealTitle),
                    ),
                  ),
                  _padBottom(
                    BitecubeDropDownField(
                      initialSelection: mealType,
                      onSelected: (value) {
                        mealType = value ?? '';
                      },
                      entries: MealType.values
                          .map(
                            (type) => DropdownMenuEntry(
                              value: type.title,
                              label: type.title,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  _padBottom(
                    BitecubeTextField(
                      onChanged: (value) {
                        mealDescription = value;
                      },
                      maxLength: 300,
                      label: context.l10n.description,
                      controller: TextEditingController(text: mealDescription),
                    ),
                  ),
                  _padBottom(
                    Row(
                      children: [
                        Expanded(
                          child: BitecubeTextField(
                            onChanged: (value) {
                              calories = int.tryParse(value) ?? 0;
                            },
                            label: context.l10n.calories,
                            isOptional: true,
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                              text: calories.toString(),
                            ),
                          ),
                        ),
                        Container(
                          width: 8,
                        ),
                        Expanded(
                          child: BitecubeTextField(
                            onChanged: (value) {
                              protein = int.tryParse(value) ?? 0;
                            },
                            label: context.l10n.protein,
                            isOptional: true,
                            keyboardType: TextInputType.number,
                            controller:
                                TextEditingController(text: protein.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _padBottom(
                    Row(
                      children: [
                        Expanded(
                          child: BitecubeTextField(
                            onChanged: (value) {
                              carbohydrates = int.tryParse(value) ?? 0;
                            },
                            label: context.l10n.carbohydrates,
                            isOptional: true,
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                              text: carbohydrates.toString(),
                            ),
                          ),
                        ),
                        Container(
                          width: 8,
                        ),
                        Expanded(
                          child: BitecubeTextField(
                            onChanged: (value) {
                              fats = int.tryParse(value) ?? 0;
                            },
                            label: context.l10n.fats,
                            isOptional: true,
                            keyboardType: TextInputType.number,
                            controller:
                                TextEditingController(text: fats.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BitecubeTextField(
                    label: context.l10n.time_of_day,
                    readOnly: true,
                    onChanged: (String value) {},
                    controller: TextEditingController(
                      text: unixTime.toTimeOfDay(),
                    ),
                    onTap: () async {
                      final initialDateTime =
                          unixTime.toDateTime() ?? DateTime.now();

                      final timeSelected = await showBitecubeTimePicker(
                        context: context,
                        initialDateTime: initialDateTime,
                      );

                      setState(
                        () {
                          unixTime = initialDateTime
                              .copyWith(
                                minute: timeSelected?.minute ??
                                    initialDateTime.minute,
                                hour:
                                    timeSelected?.hour ?? initialDateTime.hour,
                              )
                              .toUnixTime();
                        },
                      );
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<StoreBloc>().add(
                            StoreEvent.setMeal(
                              MealDTO(
                                id: id,
                                mealType: mealType,
                                mealTitle: mealTitle,
                                mealDescription: mealDescription,
                                calories: calories,
                                protein: protein,
                                carbohydrates: carbohydrates,
                                fats: fats,
                                quantity: quantity,
                                unixTime: unixTime,
                              ),
                            ),
                          );
                      BitecubeSnackBar(
                        context,
                        context.l10n.saving_meal,
                      ).show();
                    } else {
                      BitecubeSnackBar(
                        context,
                        context.l10n.please_fill_in,
                      ).show();
                    }
                  },
                  child: Text(context.l10n.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _padBottom(Widget child) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: child,
  );
}
