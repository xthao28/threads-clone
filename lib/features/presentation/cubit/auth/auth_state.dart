part of 'auth_cubit.dart';

abstract class AuthState extends Equatable{
  const AuthState();
}

class AuthInitial extends AuthState{
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState{
  final String uid;
  // ignore: prefer_const_constructors_in_immutables
  Authenticated({required this.uid});

  @override
  List<Object> get props => [uid];
}

class UnAuthenticated extends AuthState{
  @override
  List<Object> get props => [];
}
