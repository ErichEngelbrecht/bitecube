part of 'analytics_bloc.dart';

@freezed
abstract class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState({
    required String timeZone,
    required String language,
    required String occupation,
    required String industry,
    @Default(true) bool isLoading,
    @Default(false) bool isUpdating,
    @Default(false) bool isRefreshing,
  }) = _AnalyticsState;

  factory AnalyticsState.initial() => const AnalyticsState(
        timeZone: '',
        language: '',
        occupation: '',
        industry: '',
      );
}
