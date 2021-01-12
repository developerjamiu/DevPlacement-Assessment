import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../cubit/users_cubit.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';
import 'user_detail_view.dart';

class UsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(UserRepository(Client()))..getUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('User'),
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
              return _UsersList(users: state.users);
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
}

class _UsersList extends StatelessWidget {
  final List<User> users;

  const _UsersList({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].fullName),
          subtitle: Text(users[index].gender),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => UserDetailView(user: users[index]),
            ),
          ),
        );
      },
    );
  }
}