import 'package:works_app/src/features/login/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    super.userName,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    userName : json['data'] ?? '',
  );
}