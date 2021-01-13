import 'package:flutter/material.dart';

import '../../features/cars/cubit/filtered_cars_cubit.dart';
import '../models/options.dart';

class OptionListDialog extends StatefulWidget {
  final FilteredCarsCubit cubit;
  final List<String> options;
  final String type;

  const OptionListDialog({
    Key key,
    @required this.options,
    @required this.cubit,
    @required this.type,
  }) : super(key: key);

  @override
  _OptionListDialogState createState() => _OptionListDialogState();
}

class _OptionListDialogState extends State<OptionListDialog> {
  var options = <Option>[];

  @override
  void initState() {
    if (widget.type == 'Color') {
      widget.options.forEach(
        (option) {
          List<String> colors = widget.cubit.state.colors;
          if (colors == null) colors = <String>[];
          if (colors.contains(option)) {
            options.add(Option(name: option, value: true));
          } else {
            options.add(Option(name: option, value: false));
          }
        },
      );
    } else {
      widget.options.forEach(
        (option) {
          List<String> countries = widget.cubit.state.countries;
          if (countries == null) countries = <String>[];
          if (countries.contains(option)) {
            options.add(Option(name: option, value: true));
          } else {
            options.add(Option(name: option, value: false));
          }
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(options[index].name),
                    value: options[index].value,
                    onChanged: (val) {
                      setState(() {
                        options[index].value = val;
                      });
                    },
                  );
                },
              ),
            ),
            RaisedButton(
              child: Text('ADD FILTERS'),
              onPressed: () {
                List<String> opt = [];
                options.forEach((option) {
                  if (option.value == true) {
                    opt.add(option.name);
                  }
                });
                if (widget.type == 'Color') {
                  widget.cubit.colorsChanged(opt);
                } else {
                  widget.cubit.countriesChanged(opt);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
