import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/profile_state.dart';
import 'package:store/features/data/repositories/user_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository repository;

  ProfileCubit(this.repository) : super(ProfileState());

  final ImagePicker picker = ImagePicker();

  Future<void> getUser() async {
    emit(state.copyWith(isLoading: true));

    final result = await repository.getUserProfile();

    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error));
      },
      (user) {
        emit(state.copyWith(isLoading: false, user: user));
      },
    );
  }

  Future<void> pickAndUploadImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    emit(state.copyWith(isImageUploading: true));

    // await repository.imageUpload(image.path);

    final result = await repository.getUserProfile();

    result.fold(
      (error) {
        emit(state.copyWith(isImageUploading: false, error: error));
      },
      (user) {
        emit(state.copyWith(isImageUploading: false, user: user));
      },
    );
  }
}
