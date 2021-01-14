import 'package:flutter_test/flutter_test.dart';
import 'package:jamiu_okanlawon/src/contents/utilities/failure.dart';
import 'package:jamiu_okanlawon/src/features/users/cubit/users_cubit.dart';
import 'package:jamiu_okanlawon/src/features/users/model/user.dart';
import 'package:jamiu_okanlawon/src/features/users/repository/user_repository.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  UserRepository userRepository;
  UsersCubit usersCubit;

  setUp(() {
    userRepository = MockUserRepository();
    usersCubit = UsersCubit(userRepository);
  });

  group('Users Cubit: Get User', () {
    test('Should emit UsersLoading and UsersLoaded when successful', () async {
      when(userRepository.getAllUser()).thenAnswer(
        (_) async => Future.value(<User>[]),
      );

      final expected = <UsersState>[
        UsersLoading(),
        UsersLoaded(<User>[]),
      ];

      expectLater(usersCubit, emitsInOrder(expected));

      usersCubit.getUsers();
    });

    test('Should emit UsersLoading and UsersError when unsuccessful', () async {
      when(userRepository.getAllUser()).thenThrow(Failure('Fail'));

      final expected = <UsersState>[
        UsersLoading(),
        UsersError('Fail'),
      ];

      expectLater(usersCubit, emitsInOrder(expected));

      usersCubit.getUsers();
    });
  });
}
