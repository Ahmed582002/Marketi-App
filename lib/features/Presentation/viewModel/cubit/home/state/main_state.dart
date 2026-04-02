abstract class MainState {}

class MainInitial extends MainState {}

class MainChangeIndex extends MainState {
  final int index;

  MainChangeIndex(this.index);
}
