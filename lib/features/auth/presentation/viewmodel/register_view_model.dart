import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final

class RegisterViewModel extends StateNotifier<void>{
  RegisterViewModel(this.navigator):super(null);

  final RegisterViewModel navigator;

  void openLoginView(){
    navigator.openLoginView();
  }

}
