import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/repository/user_controller_repository.dart';
import 'package:arkeonil/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final String initialRoute =
            ref.read(userControlRepository).isUserSignedIn();
        return MaterialApp(
          title: 'Arkeonil',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                foregroundColor: whiteColor,
                iconTheme: IconThemeData(color: whiteColor)),
            scaffoldBackgroundColor: scaffoldBGColor,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: bottomNavigationBGColor,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: greyColor),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generate,
          initialRoute: initialRoute,
        );
      },
    );
  }
}
