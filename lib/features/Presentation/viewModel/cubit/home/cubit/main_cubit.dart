import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(MainChangeIndex(index));
  }
}
