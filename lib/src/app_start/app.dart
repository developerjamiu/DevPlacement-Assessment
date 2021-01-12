import 'package:flutter/material.dart';

import '../features/cars/view/cars_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jamiu Okanlawon',
      home: CarsView(),
    );
  }
}
