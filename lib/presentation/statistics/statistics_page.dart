import 'package:auto_route/annotations.dart';
import 'package:bitecube/application/store/store_bloc.dart';
import 'package:bitecube/l10n/l10n.dart';
import 'package:bitecube/ui_kit/bitecube_meal_chart/widgets/bitecube_meal_chart.dart';
import 'package:bitecube/ui_kit/scaffold/bitecube_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final meals = context.read<StoreBloc>().state.meals;

    return BitecubeScaffold(
      title: context.l10n.statisticsAppBarTitle,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: BitecubeChart(
              context: context,
              meals: meals,
            ),
          ),
        ],
      ),
    );
  }
}
