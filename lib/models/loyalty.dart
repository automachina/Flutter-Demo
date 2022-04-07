class LoyaltyModel {
  final levels = ['Bronze', 'Silver', 'Gold'];
  int level = 0;
  Goal? selectedGoal;
  final goals = [
    Goal(
      id: 1,
      name: 'E-Statement Opt-In',
      type: GoalType.satisfied,
      target: 1,
      progress: 0,
    ),
    Goal(
      id: 2,
      name: 'Minimum Deposit Amount',
      type: GoalType.amount,
      target: 500,
      progress: 400,
    ),
    Goal(
      id: 3,
      name: '15 Debit Card Transactions',
      type: GoalType.amount,
      target: 15,
      progress: 5,
    ),
  ];

  LoyaltyModel();

  LoyaltyModel.fromValues({
    required this.level,
    required this.selectedGoal,
  });

  LoyaltyModel copyWith({
    int? level,
    Goal? selectedGoal,
  }) {
    return LoyaltyModel.fromValues(
      level: level ?? this.level,
      selectedGoal: selectedGoal ?? this.selectedGoal,
    );
  }
}

class Goal {
  final int id;
  final String name;
  final String? description;
  final GoalType type;
  final double target;
  final double progress;
  final bool completed;

  Goal(
      {required this.id,
      required this.name,
      this.description,
      required this.type,
      required this.target,
      required this.progress,
      this.completed = false});

  Goal copyWith({
    String? name,
    String? description,
    GoalType? type,
    double? target,
    double? progress,
    bool? completed,
  }) {
    return Goal(
        id: id,
        name: name ?? this.name,
        description: description ?? this.description,
        type: type ?? this.type,
        target: target ?? this.target,
        progress: progress ?? this.progress,
        completed: completed ?? this.completed);
  }
}

enum GoalType {
  amount,
  percentage,
  satisfied,
}
