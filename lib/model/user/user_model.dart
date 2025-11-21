import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String mobileNumber;
  final String email;
  final String password;

  const UserModel({
    this.id,
    required this.mobileNumber,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      mobileNumber: json['mobileNumber'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'mobileNumber': mobileNumber,
    'email': email,
    'password': password,
  };

  @override
  List<Object?> get props => [id, mobileNumber, email, password];
}