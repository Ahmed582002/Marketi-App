import 'package:store/core/api/end_ponits.dart';

class UserModel {
  final String? id;
  final String? profilePic;
  final String email;
  final String phone;
  final String name;
  final String? address;

  UserModel({
    this.profilePic,
    required this.email,
    required this.phone,
    required this.name,
    this.address,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    final user = jsonData['message'] ?? {};

    return UserModel(
      id: user[ApiKey.id]?.toString(),
      profilePic: user[ApiKey.userImage],
      email: user[ApiKey.email] ?? "",
      phone: user[ApiKey.phone] ?? "",
      name: user[ApiKey.name] ?? "",
      address: user[ApiKey.address]?.toString(),
    );
  }
}
