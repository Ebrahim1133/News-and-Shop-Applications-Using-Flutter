// @dart=2.9
// ignore: import_of_legacy_library_into_null_safe
// ignore: unused_import
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abdullamansour/shared/components/components.dart';
// ignore: unused_import
import 'package:flutter_abdullamansour/shared/components/constants.dart';
import 'package:flutter_abdullamansour/shared/cubit/cubit.dart';
import 'package:flutter_abdullamansour/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;

        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}
