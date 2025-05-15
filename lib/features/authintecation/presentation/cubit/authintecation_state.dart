part of 'authintecation_cubit.dart';

abstract class AuthintecationState extends Equatable {
  const AuthintecationState();

  @override
  List<Object> get props => [];
}

class AuthintecationInitial extends AuthintecationState {}

class AuthintecationLoaded extends AuthintecationState {
  final UserEntity user;
  const AuthintecationLoaded({required this.user});
}

class AuthintecationError extends AuthintecationState {
  final String message;
  const AuthintecationError({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthintecationLoading extends AuthintecationState {}

class AuthintecationSuccess extends AuthintecationState {}
