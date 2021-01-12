import 'package:flutter/material.dart';

import '../model/user.dart';

class UserDetailView extends StatelessWidget {
  final User user;

  const UserDetailView({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName),
      ),
    );
  }
}
