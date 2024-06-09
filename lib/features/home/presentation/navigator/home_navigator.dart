import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/app/navigator/navigator.dart';
import 'package:student_management_starter/features/home/presentation/view/home_view.dart';
import 'package:student_management_starter/features/home/presentation/viewmodel/home_view_model.dart';

class HomeViewNavigator {
  static final homeViewModelProvider = StateNotifierProvider<HomeViewModel, int>(
    (ref) => HomeViewModel(HomeViewNavigator()),
  );

  void openHomeView() {
    NavigateRoute.pushRoute(const HomeView());
  }
}
