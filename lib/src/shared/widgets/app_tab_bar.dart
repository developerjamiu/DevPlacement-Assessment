import 'package:flutter/material.dart';

import '../../contents/constants/app_colors.dart';
import '../../contents/constants/app_styles.dart';

class AppTabBar extends StatefulWidget {
  final List<String> items;
  final int initialIndex;
  final Function(int) onChanged;

  const AppTabBar({
    Key key,
    this.initialIndex = 0,
    @required this.onChanged,
    @required this.items,
  }) : super(key: key);

  @override
  _AppTabBarState createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.items
          .map(
            (item) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = widget.items.indexOf(item);
                  widget.onChanged(_selectedIndex);
                });
              },
              child: Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text(
                  item,
                  style: _selectedIndex == widget.items.indexOf(item)
                      ? AppStyles.heading4.copyWith(color: AppColors.white)
                      : AppStyles.heading4,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
