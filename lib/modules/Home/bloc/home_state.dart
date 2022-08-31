class HomeState {
  final int count;
  final int test;

  HomeState({
    this.count = 0,
    this.test = 0,
  });

  HomeState copyWith({count}) => HomeState(count: count, test: test);
}
