class ProfileState {
  final bool isLoading;
  final bool isImageUploading;
  final dynamic user;
  final String? error;

  ProfileState({
    this.isLoading = false,
    this.isImageUploading = false,
    this.user,
    this.error,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isImageUploading,
    dynamic user,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isImageUploading: isImageUploading ?? this.isImageUploading,
      user: user ?? this.user,
      error: error,
    );
  }
}
