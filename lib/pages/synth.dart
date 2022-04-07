import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:test_drive/actions/loyalty.dart';
import 'package:test_drive/components/custom_border.dart';
import 'package:test_drive/components/perspective.dart';
import 'package:test_drive/components/synth/synthscape.dart';
import 'package:test_drive/models/app_state.dart';
import 'package:test_drive/models/loyalty.dart';
import 'package:test_drive/utilities/color.dart';
import 'package:test_drive/utilities/math.dart';

class SynthPage extends StatelessWidget {
  const SynthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Synthscape(
      child: StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Perspective(
                angle: angleToRadians(-60),
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.antiAlias,
                  itemCount: vm.goals.length,
                  itemBuilder: (context, index) {
                    final goal = vm.goals[index];
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: CustomBorder.all(
                          borderPaints: [
                            Paint()
                              ..color = Colors.tealAccent
                              ..strokeWidth = 4
                              ..style = PaintingStyle.stroke
                              ..isAntiAlias = true
                              ..maskFilter =
                                  MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(8)),
                            Paint()
                              ..color = Colors.white
                              ..strokeWidth = 1
                              ..style = PaintingStyle.stroke
                              ..isAntiAlias = true,
                          ],
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xC02E1738),
                            Color(0xC0021820),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          goal.name,
                          style: context.theme.textTheme.headline5,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
