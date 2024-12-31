import 'package:ai_app/provider/auth_provider.dart';
import 'package:ai_app/screens/enter_code_screen.dart';
import 'package:ai_app/screens/home_screen.dart';
import 'package:ai_app/screens/login_screen.dart';
import 'package:ai_app/screens/select_login_screen.dart';
import 'package:ai_app/screens/sign_up_screen.dart';
import 'package:ai_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Exposes a [GoRouter] that uses a [Listenable] to refresh its internal state.
///
/// With Riverpod, we can't register a dependency via an Inherited Widget,
/// thus making this implementation the "leanest" possible
///
/// To sync our app state with this our router, we simply update our listenable via `ref.listen`,
/// and pass it to GoRouter's `refreshListenable`.
/// In this example, this will trigger redirects on any authentication change.
///
/// Obviously, more logic could be implemented here, but again, this is meant to be a simple example.
/// You can always build more listenables and even merge more than one into a more complex `ChangeNotifier`,
/// but that's up to your case and out of this scope.

GoRouter? appRouter;

@riverpod
GoRouter router(Ref ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref
    ..onDispose(isAuth.dispose) // don't forget to clean after yourselves (:
    // update the listenable, when some provider value changes
    // here, we are just interested in wheter the user's logged in
    ..listen(
      asyncAuthProvider
          .select((value) => value.whenData((value) => value.isAuth)),
      (_, next) {
        isAuth.value = next;
      },
    );

  final router = GoRouter(
    navigatorKey: routerKey,
    refreshListenable: isAuth,
    initialLocation: Routes.loginRoute,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.loginRoute,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.homeRoute,
        builder: (_, __) => const HomeScreen(),
      )
      // GoRoute(
      //   path: Routes.mainRoute,
      //   builder: (_, __) => const SelectLoginScreen(),
      //   routes: [
      //     GoRoute(
      //       path: Routes.login,
      //       builder: (_, __) => const LoginScreen(),
      //     ),
      //     GoRoute(
      //       path: Routes.signup,
      //       builder: (_, __) => const SignUpScreen(),
      //       routes: [
      //         GoRoute(
      //           path: Routes.code,
      //           builder: (_, __) => const EnterCodeScreen(),
      //         )
      //       ],
      //     ),
      //   ],
      // ),
    ],
    redirect: (context, state) {
      if ((!isAuth.value.hasValue && !isAuth.value.isLoading)) {
        debugPrint("Returning because no value");
        return Routes.mainRoute;
      }

      final auth = isAuth.value.value ?? false;

      final isSplash = state.uri.path == Routes.mainRoute;
      if (isSplash) {
        return auth ? Routes.homeRoute : Routes.mainRoute;
      }

      final isLoggingIn = (state.uri.path == Routes.mainRoute ||
          state.uri.path == Routes.loginRoute);
      if (isLoggingIn) return auth ? Routes.homeRoute : null;

      return auth ? null : state.uri.path;
    },
  );
  ref.onDispose(router.dispose); // always clean up after yourselves (:

  appRouter = router;

  return router;
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return router(ref);
});
