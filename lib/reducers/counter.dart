import '../actions/counter.dart';
import '/models/counter.dart';

CounterModel counterReducer(CounterModel state, dynamic action) {
  if (action is IncrementAction) {
    return state.increase();
  } else if (action is DecrementAction) {
    return state.decrease();
  } else if (action is ResetAction) {
    return state.reset();
  } else if (action is UpdateIncrementAction) {
    return state.copyWith(increment: action.value);
  }
  return state;
}
