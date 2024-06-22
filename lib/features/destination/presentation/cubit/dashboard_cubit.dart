import 'package:course_travel/features/destination/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);

  change(int i) {
    emit(i);
  }

  final List menuDashboardList = [
    ['Home', Icons.home, const HomePage()],
    [
      'Near',
      Icons.near_me,
      const Center(
        child: Text('Near'),
      )
    ],
    [
      'Favorite',
      Icons.favorite,
      const Center(
        child: Text('Favorite'),
      )
    ],
    [
      'Profile',
      Icons.person,
      const Center(
        child: Text('Profile'),
      )
    ],
  ];

  Widget get page => menuDashboardList[state][2];
}
