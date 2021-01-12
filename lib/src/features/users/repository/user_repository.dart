import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../contents/utilities/failure.dart';
import '../model/user.dart';

class UserRepository {
  final http.Client client;

  UserRepository(this.client);

  Future<List<User>> getAllUser() async {
    List<User> users;
    try {
      final response = await client
          .get("https://android-json-test-api.herokuapp.com/accounts");

      if (response.statusCode == 200) {
        dynamic usersResponse = json.decode(response.body);

        users =
            List<User>.from(usersResponse.map((user) => User.fromJson(user)));
      } else {
        _response(response);
      }
    } on SocketException {
      throw Failure(
          'No Internet connection. Please check you internet connection');
    } on HttpException {
      throw Failure("Something went wrong");
    } on FormatException {
      throw Failure("Bad response format.");
    }
    return users;
  }

  void _response(http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw Failure('Bad Request ${response.body}');
      case 401:

      case 403:
        throw Failure('Unauthorised Request ${response.body}');
      case 500:

      default:
        throw Failure(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
