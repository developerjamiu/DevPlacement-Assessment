import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../contents/constants/app_colors.dart';
import '../../../contents/constants/app_styles.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/option_list_dialog.dart';
import '../../../contents/constants/app_lists.dart';

import '../cubit/filtered_cars_cubit.dart';

class FilterCarsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilteredCarsCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocConsumer<FilteredCarsCubit, FilteredCarsState>(
              listener: (context, state) {},
              builder: (context, state) {
                final _cubit = context.watch<FilteredCarsCubit>();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appBar(_cubit),
                    SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        children: [
                          Text('Year', style: AppStyles.bodyText1),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _cubit.startYearController,
                                  label: 'FROM',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: AppTextField(
                                  controller: _cubit.endYearController,
                                  label: 'TO',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('Gender', style: AppStyles.bodyText1),
                          Row(
                            children: [
                              Radio(
                                value: 'All',
                                groupValue: state.gender,
                                onChanged: _cubit.genderChanged,
                              ),
                              Text('ALL'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'Male',
                                groupValue: state.gender,
                                onChanged: _cubit.genderChanged,
                              ),
                              Text('MALE'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'Female',
                                groupValue: state.gender,
                                onChanged: _cubit.genderChanged,
                              ),
                              Text('FEMALE'),
                            ],
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text('Colors', style: AppStyles.bodyText1),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                child: OptionListDialog(
                                  options: colorsList,
                                  cubit: _cubit,
                                  type: 'Color',
                                ),
                              );
                            },
                          ),
                          buildOptionsList(state.colors),
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title:
                                Text('Countries', style: AppStyles.bodyText1),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                child: OptionListDialog(
                                  options: countriesList,
                                  cubit: _cubit,
                                  type: 'Country',
                                ),
                              );
                            },
                          ),
                          buildOptionsList(state.countries),
                          SizedBox(height: 64.0),
                          RaisedButton(
                            onPressed: () {},
                            child: Text('Filter'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar(FilteredCarsCubit cubit) {
    return Builder(
      builder: (context) => BlocBuilder<FilteredCarsCubit, FilteredCarsState>(
        builder: (context, state) => Row(
          children: [
            GestureDetector(
              child: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
            SizedBox(width: 24.0),
            Text(
              'Filter',
              style: AppStyles.heading4.copyWith(color: AppColors.white),
            ),
            Spacer(),
            InkWell(
              onTap: () => context.read<FilteredCarsCubit>().resetStates(),
              child: Text('RESET'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionsList(List<String> items) {
    return items == null || items.isEmpty
        ? Container()
        : Wrap(
            children: items
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Text(item),
                    decoration: BoxDecoration(color: AppColors.accent),
                  ),
                )
                .toList(),
          );
  }
}
