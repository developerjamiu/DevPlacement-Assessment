import 'package:flutter/material.dart';
import '../features/home/view/home_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jamiu Okanlawon',
      home: HomeView(),
      theme: ThemeData(
        buttonTheme: ButtonThemeData(height: 48),
      ),
    );
  }
}
