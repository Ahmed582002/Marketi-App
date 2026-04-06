import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:store/features/Presentation/viewModel/cache/cache_helper.dart';
import 'package:store/core/api/api_consumer.dart';
import 'package:store/core/api/end_ponits.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/functions/upload_image_to_api.dart';
import 'package:store/features/data/models/sign_in_model.dart';
import 'package:store/features/data/models/sign_up_model.dart';
import 'package:store/features/data/models/user_model.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});
  Future<Either<String, SignInModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        EndPoint.signIn,
        data: {ApiKey.email: email, ApiKey.password: password},
      );
      final user = SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user.token);
      CacheHelper().saveData(key: ApiKey.token, value: user.token);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, SignUpModel>> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
    XFile? profilePic,
  }) async {
    try {
      Map<String, dynamic> data = {
        ApiKey.name: name,
        ApiKey.phone: phone,
        ApiKey.email: email,
        ApiKey.password: password,
        ApiKey.confirmPassword: confirmPassword,
      };

      if (profilePic != null) {
        data[ApiKey.userImage] = await uploadImageToAPI(profilePic);
      }

      final response = await api.post(EndPoint.signUp, data: data);

      final signUPModel = SignUpModel.fromJson(response);
      return Right(signUPModel);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(
        EndPoint.getUserDataEndPoint(CacheHelper().getData(key: ApiKey.id)),
      );
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }
}
