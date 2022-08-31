import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<CounterEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    int num;
    on<CounterIncrementPressed>((event, emit) => {
          num = state.count + event.increment,
          emit(state.copyWith(count: num))
        });
    on<CounterDecrementPressed>((event, emit) => {
          num = state.count - event.decrement,
          emit(state.copyWith(count: num))
        });
  }
}
