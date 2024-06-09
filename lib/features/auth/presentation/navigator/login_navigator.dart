import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/app/navigator/navigator.dart';
import 'package:student_management_starter/features/auth/presentation/navigator/register_navigator.dart';
import 'package:student_management_starter/features/auth/presentation/view/login_view.dart';
import 'package:student_management_starter/features/home/presentation/view/home_view.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());

//page le call garda mixin use hunxa
class LoginViewNavigator with RegisterViewRoute, HomeViewRoute {}

mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.pushRoute(const LoginView());
  }
}
mixin HomeViewRoute {
  openHomeView() {
    NavigateRoute.pushRoute(const HomeView());
  }
}
