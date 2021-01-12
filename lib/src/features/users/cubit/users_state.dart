part of 'users_cubit.dart';

@immutable
abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  const UsersLoaded(this.users);

  final List<User> users;

  @override
  List<Object> get props => [users];
}

class UsersError extends UsersState {
  const UsersError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
