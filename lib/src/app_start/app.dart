import 'package:flutter/material.dart';

import '../features/users/view/users_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jamiu Okanlawon',
      home: UsersView(),
    );
  }
}
