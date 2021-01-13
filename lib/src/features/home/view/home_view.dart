import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../shared/widgets/app_tab_bar.dart';
import '../../cars/cubit/cars_cubit.dart';
import '../../cars/repository/car_repository.dart';
import '../../cars/view/cars_view.dart';
import '../../cars/view/filter_cars_view.dart';
import '../../users/cubit/users_cubit.dart';
import '../../users/repository/user_repository.dart';
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
          create: (context) =>
              CarsCubit(CarRepository(Permission.storage))..getCars(),
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
                Row(
                  children: [
                    Expanded(
                      child: AppTabBar(
                        onChanged: onPageChanged,
                        items: ['Cars', 'Users'],
                      ),
                    ),
                    currentPage == 0 ? IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => FilterCarsView()),
                      ) ,
                    ): Container(),
                  ],
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
