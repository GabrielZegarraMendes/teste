import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:works_app/src/core/cubit/generic_state.dart';
import 'package:works_app/src/features/login/domain/entities/login_entity.dart';
import 'package:works_app/src/features/login/domain/usecases/login_usecase.dart';

class LoginCubit extends Cubit<GenericState> {
  late LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(InitState());

  LoginEntity? loginEntity;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool validate = false;

  Future<void> login(
    String email,
    String password,
  ) async {
    emit(LoadingState());
    loginEntity = await loginUseCase.call(email, password);
    if (loginEntity != null) {
      Modular.to.pushReplacementNamed('/product');
    }
    if (loginEntity == null) {
      Future.delayed(const Duration(seconds: 1), () => emit(InitState()));
      emit(ErrorState());
    }
  }

  void validateBottom(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      validate = true;
      emit(LoadingState());
      emit(InitState());
      return;
    }
    validate = false;
    emit(LoadingState());
    emit(InitState());
    return;
  }

  Future<void> logout() async {
    bool logout = await loginUseCase.signOut();
    if (logout) {
      emailController.clear();
      passwordController.clear();
      emit(InitState());
      Modular.to
          .pushNamedAndRemoveUntil(Modular.initialRoute, (value) => false);
    }
  }
}
