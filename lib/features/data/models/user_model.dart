import 'package:store/core/api/end_ponits.dart';

class UserModel {
  final String? id;
  final String? profilePic;
  final String email;
  final String phone;
  final String name;
  final Map<String, dynamic>? address;

  UserModel({
    this.profilePic,
    required this.email,
    required this.phone,
    required this.name,
    this.address,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['user'][ApiKey.id],
      profilePic: jsonData['user'][ApiKey.userImage],
      email: jsonData['user'][ApiKey.email],
      phone: jsonData['user'][ApiKey.phone],
      name: jsonData['user'][ApiKey.name],
      address: jsonData['user'][ApiKey.address],
    );
  }
}
