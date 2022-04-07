import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:test_drive/actions/loyalty.dart';
import 'package:test_drive/components/drop_shadow.dart';
import 'package:test_drive/components/loyalty/loyalty_gauge.dart';
import 'package:test_drive/components/loyalty/loyalty_item.dart';
import 'package:test_drive/models/app_state.dart';
import 'package:test_drive/models/loyalty.dart';
import 'package:test_drive/utilities/color.dart';

class LoyaltyPage extends StatelessWidget {
  const LoyaltyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dropShadowColor = context.themedColor(Colors.black, Colors.tealAccent);
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: DropShadow(
                      opacity: 0.6,
                      color: dropShadowColor,
                      offset: const Offset(3, 3),
                      sigma: 7,
                      child: LoyaltyGauge(goal: vm.selectedGoal),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: vm.goals.length,
                    itemBuilder: (context, index) {
                      return LoyaltyItem(
                        goal: vm.goals[index],
                        onTap: () => vm.onGoalSelected(vm.goals[index]),
                        color: Colors.white,
                        backgroundColor: Colors.teal,
                        dropShadowColor: dropShadowColor,
                      );
                    },
                  ),
                ),
              ],
            ));
  }
}

class _ViewModel {
  final String levelName;
  final int level;
  final List<Goal> goals;
  final Goal? selectedGoal;
  final Function(Goal) onGoalSelected;

  const _ViewModel({
    required this.levelName,
    required this.level,
    required this.goals,
    required this.selectedGoal,
    required this.onGoalSelected,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final loyalty = store.state.loyalty;
    return _ViewModel(
      levelName: loyalty.levels[loyalty.level],
      level: loyalty.level,
      goals: loyalty.goals,
      selectedGoal: loyalty.selectedGoal,
      onGoalSelected: (goal) => store.dispatch(GoalSelectedAction(goal)),
    );
  }
}
