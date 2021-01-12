import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../cubit/users_cubit.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';

class UsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(UserRepository(Client()))..getUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cars'),
        ),
        body: BlocConsumer<UsersCubit, UsersState>(
          listener: (context, state) {
            if (state is UsersError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is UsersInitial) {
              return buildInitialInput();
            } else if (state is UsersLoading) {
              return buildLoading();
            } else if (state is UsersLoaded) {
              return buildColumnWithData(state.users);
            } else {
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Container();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  ListView buildColumnWithData(List<User> users) {
    return ListView(
      children: users
          .map(
            (user) => ListTile(
              title: Text(user.fullName),
              subtitle: Text(user.gender),
            ),
          )
          .toList(),
    );
  }
}
