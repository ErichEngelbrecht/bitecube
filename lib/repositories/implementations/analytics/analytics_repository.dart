// ignore_for_file: deprecated_member_use

import 'package:bitecube/repositories/interfaces/analytics/i_analytics_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAnalyticsRepository)
class AnalyticsRepository implements IAnalyticsRepository {
  AnalyticsRepository();

  @override
  Unit sendAnalytics() {
    return unit;
  }
}
