import 'package:bigagent/models/auth_data.dart';
import 'package:bigagent/models/user.dart';
import 'package:bigagent/router/app_router.dart';
import 'package:bigagent/services/auth_service.dart';
import 'package:bigagent/services/storage_service.dart';
import 'package:bigagent/utils/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AuthProvider extends AsyncNotifier<AuthData> {
  Future<AuthData> _checkAuthenticated() async {
    try {
      final response = await AuthService.checkAuthenticated();

      return response;
    } catch (_) {
      return AuthData(isAuth: false, user: null);
    }
  }

  @override
  Future<AuthData> build() async {
    return _checkAuthenticated();
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response =
          await AuthService.login(handle: email, password: password);

      final token = response["token"];
      final user = User.fromJson(response["user"]);

      await StorageService().saveKey("user_token", token);

      appRouter?.replace(Routes.homeRoute);

      return AuthData(isAuth: true, user: user);
    });
  }

  Future<void> signUp({
    required String name,
    required String emailAddress,
    required String password,
    required int code,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await AuthService.signUp(
        emailAddress: emailAddress,
        password: password,
        name: name,
        code: code,
      );

      final token = response["token"];
      final user = User.fromJson(response["user"]);

      await StorageService().saveKey("user_token", token);

      return AuthData(isAuth: true, user: user);
    });
  }

  Future<void> getCode({
    required String emailAddress,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      state = AsyncValue.error("invalid_password", StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();

    await AuthService.requestCode(emailAddress);

    state = AsyncValue.data(AuthData(isAuth: false, user: null));
  }

  Future<void> logout() async {
    await AuthService.logout();

    await StorageService().removeKey("user_token");

    appRouter?.replace(Routes.loginRoute);

    state = AsyncValue.data(AuthData(isAuth: false, user: null));
  }
}

final asyncAuthProvider = AsyncNotifierProvider<AuthProvider, AuthData>(() {
  return AuthProvider();
});
