enum MacroType {
  CARBOHYDRATES('Carbohydrates'),
  PROTEIN('Protein'),
  FATS('Fats'),
  CALORIES('Calories');

  const MacroType(this.title);

  final String title;

  static MacroType fromString(String mealType) {
    return MacroType.values.firstWhere(
      (type) => type.name.toLowerCase() == mealType.toLowerCase(),
      orElse: () => MacroType.CALORIES,
    );
  }
}
