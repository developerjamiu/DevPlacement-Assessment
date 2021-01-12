import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../contents/utilities/failure.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserRepository _userRepository;

  UsersCubit(this._userRepository) : super(UsersInitial());

  Future<void> getUsers() async {
    try {
      emit(UsersLoading());
      final user = await _userRepository.getAllUser();
      emit(UsersLoaded(user));
    } on Failure catch (f) {
      emit(UsersError(f.message));
    }
  }
}
