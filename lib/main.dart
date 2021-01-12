import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'src/app_start/app.dart';
import 'src/features/users/model/user.dart';
import 'src/features/users/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<User> users = await UserRepository(http.Client()).getAllUser();

  users.forEach((user) {
    print(user.toString());
  });

  runApp(App());
}
