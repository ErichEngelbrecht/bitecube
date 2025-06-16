import 'package:bitecube/repositories/interfaces/analytics/i_analytics_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'analytics_bloc.freezed.dart';

part 'analytics_event.dart';

part 'analytics_state.dart';

@Injectable()
class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc(this._analyticsRepository) : super(AnalyticsState.initial()) {
    on<SendAnalytics>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));

        _analyticsRepository.sendAnalytics();

        emit(
          state.copyWith(
            isLoading: false,
            isRefreshing: false,
          ),
        );
      },
    );
  }

  final IAnalyticsRepository _analyticsRepository;
}
