import 'package:redux/redux.dart';
import 'package:redux_saga/redux_saga.dart';
import '/models/app_state.dart';
import '/reducers/root.dart';
import '/sagas/root.dart';

Store<AppState> createStore() {
  final SagaMiddleware _sagaMiddleware = createSagaMiddleware();
  final _store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      applyMiddleware(_sagaMiddleware),
    ],
  );

  _sagaMiddleware.setStore(_store);
  _sagaMiddleware.run(rootSaga);

  return _store;
}
