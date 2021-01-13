import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:jamiu_okanlawon/src/features/cars/cubit/cars_cubit.dart';
import 'package:jamiu_okanlawon/src/features/cars/repository/car_repository.dart';
import 'package:jamiu_okanlawon/src/features/users/cubit/users_cubit.dart';
import 'package:jamiu_okanlawon/src/features/users/repository/user_repository.dart';

import '../../../shared/widgets/app_tab_bar.dart';
import '../../cars/view/cars_view.dart';
import '../../users/view/users_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPage = 0;

  List<Widget> pages = [
    CarsView(),
    UsersView(),
  ];

  void onPageChanged(int pageIndex) {
    setState(() {
      currentPage = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CarsCubit>(
          create: (context) => CarsCubit(CarRepository())..getCars(),
        ),
        BlocProvider<UsersCubit>(
          create: (context) => UsersCubit(UserRepository(Client()))..getUsers(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                AppTabBar(
                  onChanged: onPageChanged,
                  items: ['Cars', 'Users'],
                ),
                SizedBox(height: 24),
                Expanded(child: pages[currentPage]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
