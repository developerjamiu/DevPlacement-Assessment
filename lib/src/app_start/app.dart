import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

import '../features/cars/cubit/cars_cubit.dart';
import '../features/cars/cubit/filtered_cars_cubit.dart';
import '../features/cars/repository/car_repository.dart';
import '../features/home/view/home_view.dart';
import '../features/users/cubit/users_cubit.dart';
import '../features/users/repository/user_repository.dart';

class App extends StatelessWidget {
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
      child: BlocBuilder<CarsCubit, CarsState>(
        builder: (context, state) {
          final _cubit = context.watch<CarsCubit>();
          return BlocProvider(
            create: (context) => FilteredCarsCubit(_cubit),
            child: MaterialApp(
              title: 'Jamiu Okanlawon',
              home: HomeView(),
              theme: ThemeData(
                buttonTheme: ButtonThemeData(height: 48),
              ),
            ),
          );
        },
      ),
    );
  }
}
