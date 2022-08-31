class HomeState {
  final int count;

  HomeState({this.count = 0});

  HomeState copyWith({count}) => HomeState(count: count);
}
