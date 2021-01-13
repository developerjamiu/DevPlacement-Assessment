import 'package:flutter/material.dart';

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
    return Scaffold(
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
    );
  }
}
