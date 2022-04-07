import 'package:test_drive/actions/loyalty.dart';
import 'package:test_drive/models/loyalty.dart';

LoyaltyModel loyaltyReducer(LoyaltyModel state, dynamic action) {
  if (action is GoalSelectedAction) {
    return state.copyWith(selectedGoal: action.goal);
  } else if (action is LoyaltyLevelUpdatedAction) {
    return state.copyWith(level: action.level);
  }
  return state;
}
