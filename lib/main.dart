import 'package:kinship_bots/provider/app_purchases_provider.dart';
import 'package:kinship_bots/router/app_router.dart';
import 'package:kinship_bots/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    ref.watch(asyncAppPurchasesProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
            textScaler: data.textScaler.clamp(
              minScaleFactor: 1,
              maxScaleFactor: 1.4,
            ),
          ),
          child: child!,
        );
      },
      title: 'Kinship Codes',
      theme: CustomTheme.defaultTheme,
      routerConfig: goRouter,
    );
  }
}
