import 'package:hive/hive.dart';

part "register_model.g.dart";

@HiveType(typeId: 1)
class RegisterModel{

  RegisterModel({required this.username, required this.password});

  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @override
  String toString() {
    return 'RegisterModel{name: $username, password: $password}';
  }
}