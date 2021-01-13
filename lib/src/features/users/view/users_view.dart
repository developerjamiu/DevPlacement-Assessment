import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/users_cubit.dart';
import '../model/user.dart';
import 'user_detail_view.dart';

class UsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
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
      physics: BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(users[index].avatar),
          ),
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
