// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/main_screen.dart';
import 'package:safe_hi/provider/nav/bottom_nav_provider.dart';
import 'package:safe_hi/view/login/login_page.dart';
import 'package:safe_hi/view_model/user_view_model.dart';
import 'package:safe_hi/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userVM = UserViewModel(repository: UserRepository());
  await userVM.tryAutoLogin();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserViewModel>.value(value: userVM),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<UserViewModel>().isLoggedIn;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const MainScreen() : const LoginPage(),
    );
  }
}
