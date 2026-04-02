import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/profile_state.dart';
import 'package:store/features/data/repositories/user_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository repository;

  ProfileCubit(this.repository) : super(ProfileState());

  final ImagePicker picker = ImagePicker();

  Future<void> getUser() async {
    try {
      emit(state.copyWith(isLoading: true));

      final user = await repository.getUserProfile();

      emit(state.copyWith(isLoading: false, user: user));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> pickAndUploadImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    try {
      emit(state.copyWith(isImageUploading: true));

      // await repository.imageUploud(image.path);

      final user = await repository.getUserProfile();

      emit(state.copyWith(isImageUploading: false, user: user));
    } catch (e) {
      emit(state.copyWith(isImageUploading: false, error: e.toString()));
    }
  }
}
