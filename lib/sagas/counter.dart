import 'package:redux_saga/redux_saga.dart';
import '/actions/counter.dart';

incrementAsync({dynamic action}) sync* {
  yield Call(print, args: ['incrementAsync']);
}

decrementAsync({dynamic action}) sync* {
  yield Call(print, args: ['decrementAsync']);
}

resetAsync({dynamic action}) sync* {
  yield Call(print, args: ['resetAsync']);
}

counterWatcher() sync* {
  yield TakeEvery(incrementAsync, pattern: IncrementAction);
  yield TakeEvery(decrementAsync, pattern: DecrementAction);
  yield TakeEvery(resetAsync, pattern: ResetAction);
}
