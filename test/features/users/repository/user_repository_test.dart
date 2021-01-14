import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jamiu_okanlawon/src/contents/utilities/failure.dart';
import 'package:jamiu_okanlawon/src/features/users/model/user.dart';
import 'package:jamiu_okanlawon/src/features/users/repository/user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  http.Client client;
  UserRepository userRepository;

  setUp(() {
    client = MockClient();
    userRepository = UserRepository(client);
  });

  group('User Repository: Get All User', () {
    test('Should return a list of users when successful', () async {
      when(client.get('https://android-json-test-api.herokuapp.com/accounts'))
          .thenAnswer(
        (realInvocation) => Future.value(
            http.Response(json.encode(<Map<String, dynamic>>[]), 200)),
      );

      final users = await userRepository.getAllUser();

      expect(users, <User>[]);
    });

    test('Should throw an error when unsuccessful', () async {
      when(client.get('https://android-json-test-api.herokuapp.com/accounts'))
          .thenThrow(Failure('Fail'));

      expect(
          () => userRepository.getAllUser(), throwsA(isInstanceOf<Failure>()));
    });
  });
}
