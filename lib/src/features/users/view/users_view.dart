import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamiu_okanlawon/src/contents/constants/app_colors.dart';
import 'package:jamiu_okanlawon/src/contents/constants/app_styles.dart';

import '../cubit/users_cubit.dart';
import '../model/user.dart';
import 'user_detail_view.dart';

class UsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {},
      builder: (context, state) {
        final _cubit = context.watch<UsersCubit>();

        if (state is UsersError) {
          return buildErrorState(state.message, _cubit);
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

  Widget buildErrorState(String message, UsersCubit cubit) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error,
            size: 48,
            color: AppColors.errorColor,
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: AppStyles.bodyText1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          RaisedButton(
            onPressed: cubit.getUsers,
            child: Text('Retry'),
          ),
        ],
      ),
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
          leading: Hero(
            tag: 'avatar${users[index].id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(users[index].avatar),
            ),
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
