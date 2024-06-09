import 'package:student_management_starter/app/navigator/navigator.dart';
import 'package:student_management_starter/features/auth/presentation/view/register_view.dart';


//view uses this
class RegisterViewNavigator{}

mixin RegisterViewRoute{
  openRegisterView(){
    NavigateRoute.pushRoute(const RegisterView());
  }
}