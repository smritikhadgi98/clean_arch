import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/home/presentation/navigator/home_navigator.dart';

class HomeViewModel extends StateNotifier<int> {
  HomeViewModel(this.navigator) : super(0);

  final HomeViewNavigator navigator;

  void setCurrentIndex(int index) {
    state = index;
  }

  void openHomeView() {
    navigator.openHomeView();
  }
}
