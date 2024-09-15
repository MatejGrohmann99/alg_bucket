import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  const UserData({
    required this.displayName,
    required this.email,
  });

  final String displayName;
  final String email;

  @override
  List<Object?> get props => [displayName, email];
}