enum PeriodOfDaysType {
  WEEK('Past Week', 7, 7),
  FOUR_WEEKS('Past 4 Weeks', 28, 4),
  THREE_DAYS('Past 3 Days', 3, 3);

  const PeriodOfDaysType(this.title, this.days, this.splitAmount);

  final String title;
  final int days;
  final int splitAmount;

  static PeriodOfDaysType fromString(String mealType) {
    return PeriodOfDaysType.values.firstWhere(
      (type) => type.title.toLowerCase() == mealType.toLowerCase(),
      orElse: () => PeriodOfDaysType.THREE_DAYS,
    );
  }
}
