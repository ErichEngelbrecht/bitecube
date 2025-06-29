enum MealType {
  BREAKFAST('Breakfast'),
  LUNCH('Lunch'),
  DINNER('Dinner'),
  SNACK('Snack');

  const MealType(this.title);

  final String title;

  static MealType fromString(String mealType) {
    return MealType.values.firstWhere(
      (type) => type.name.toLowerCase() == mealType.toLowerCase(),
      orElse: () => MealType.BREAKFAST,
    );
  }
}
