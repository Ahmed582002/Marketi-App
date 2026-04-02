class NewPasswordState {
  final bool loading;

  NewPasswordState({this.loading = false});

  NewPasswordState copyWith({bool? loading}) {
    return NewPasswordState(loading: loading ?? this.loading);
  }
}
