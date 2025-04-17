import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/main_screen.dart';
import 'package:safe_hi/provider/id/report_id.dart';
import 'package:safe_hi/provider/nav/bottom_nav_provider.dart';
import 'package:safe_hi/service/user_service.dart';
import 'package:safe_hi/view/login/login_page.dart';
import 'package:safe_hi/view_model/user_view_model.dart';
import 'package:safe_hi/repository/report_repository.dart';
import 'package:safe_hi/service/report_service.dart';
import 'package:safe_hi/view_model/report_view_model.dart';
import 'package:safe_hi/util/connectivity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userVM = UserViewModel(UserService());
  await userVM.tryAutoLogin();

  runApp(
    ConnectivityWrapper(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserViewModel>.value(value: userVM),
          ChangeNotifierProvider(create: (_) => BottomNavProvider()),
          ChangeNotifierProvider(create: (_) => ReportIdProvider()),
          ChangeNotifierProvider(
            create: (_) => ReportViewModel(
              repository: ReportRepository(service: ReportService()),
            )..fetchTargets(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _networkChecked = false;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _checkInitialNetwork();
  }

  Future<void> _checkInitialNetwork() async {
    final connected = await isInternetAvailable();
    if (!connected) {
      _showNetworkDialog();
    }

    setState(() {
      _hasInternet = connected;
      _networkChecked = true;
    });
  }

  void _showNetworkDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('인터넷 연결 없음'),
          content: const Text('인터넷이 연결되어 있지 않습니다.\n연결 후 다시 시도해주세요.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _checkInitialNetwork(); // 다시 시도
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<UserViewModel>().isLoggedIn;

    if (!_networkChecked) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _hasInternet
          ? (isLoggedIn ? const MainScreen() : const LoginPage())
          : const Scaffold(), // 연결 없을 땐 빈 화면 유지 (팝업으로 안내 중)
    );
  }
}
