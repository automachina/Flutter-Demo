import '/models/loyalty.dart';

class GoalSelectedAction {
  final Goal goal;

  GoalSelectedAction(this.goal);
}

class LoyaltyLevelUpdatedAction {
  final int level;

  LoyaltyLevelUpdatedAction(this.level);
}
