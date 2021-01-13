import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/app_tab_bar.dart';
import '../../cars/view/cars_view.dart';
import '../../cars/view/filter_cars_view.dart';
import '../../users/view/users_view.dart';
import '../cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  final List<Widget> pages = [
    CarsView(),
    UsersView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: BlocBuilder<HomeCubit, int>(
              builder: (context, state) => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppTabBar(
                          onChanged: context.watch<HomeCubit>().onPageChanged,
                          items: ['Cars', 'Users'],
                        ),
                      ),
                      state == 0
                          ? IconButton(
                              icon: Icon(Icons.filter_list),
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => FilterCarsView()),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(height: 24),
                  Expanded(child: pages[state]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
