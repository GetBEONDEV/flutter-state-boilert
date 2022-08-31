abstract class CounterEvent {}

/// Notifies bloc to increment state.
class CounterIncrementPressed extends CounterEvent {
  final int increment;

  CounterIncrementPressed(this.increment);
}

/// Notifies bloc to decrement state.
class CounterDecrementPressed extends CounterEvent {
  final int decrement;

  CounterDecrementPressed(this.decrement);
}
