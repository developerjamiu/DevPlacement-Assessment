import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jamiu_okanlawon/src/contents/constants/app_colors.dart';

import '../../../contents/constants/app_styles.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(),
              SizedBox(height: 24),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(user.avatar),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      user.fullName,
                      style: AppStyles.heading6,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      user.gender,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Created on: ${DateFormat.yMMMEd().format(user.createdAt)}',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text('Colors'),
                    SizedBox(height: 8),
                    Divider(color: AppColors.accent, thickness: 2),
                    user.colors.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('No Color for this user'),
                            ),
                          )
                        : buildUserInfoList(user.colors),
                    SizedBox(height: 16),
                    Text('Countries'),
                    SizedBox(height: 8),
                    Divider(color: AppColors.accent, thickness: 2),
                    user.countries.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('No Country for this user'),
                            ),
                          )
                        : buildUserInfoList(user.countries),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Text(
          'Back',
          style: AppStyles.heading4,
        ),
      ),
    );
  }

  Widget buildUserInfoList(List<String> items) {
    return Wrap(
      children: items
          .map(
            (item) => Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 24,
              ),
              margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Text(item),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          )
          .toList(),
    );
  }
}
