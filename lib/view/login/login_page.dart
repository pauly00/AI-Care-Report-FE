import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/main_screen.dart';
import 'package:safe_hi/view/signup/terms_agreement_page.dart';
import 'package:safe_hi/view_model/user_view_model.dart';
import 'package:safe_hi/util/responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAutoLogin = false;
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);

    final userVM = Provider.of<UserViewModel>(context, listen: false);
    final result = await userVM.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      saveLogin: _isAutoLogin,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success']) {
      // ✅ Navigator는 마지막에만!
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('로그인 실패'),
          content: Text(result['msg']),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(horizontal: responsive.paddingHorizontal),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logoicon.png',
                  width: responsive.imageSize + 10,
                  height: responsive.imageSize + 10,
                ),
                SizedBox(height: responsive.itemSpacing),
                Text(
                  '안심하이에 오신 걸 환영합니다.',
                  style: TextStyle(
                    fontSize: responsive.fontBase,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFB3A5A5),
                  ),
                ),
                SizedBox(height: responsive.sectionSpacing * 2),

                // 이메일 입력
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    labelStyle: TextStyle(
                      color: const Color(0xFF9D9D9D),
                      fontSize: responsive.fontSmall,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: responsive.itemSpacing,
                      horizontal: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFE0DCDC)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFFB5457)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: responsive.itemSpacing),

                // 비밀번호 입력
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    labelStyle: TextStyle(
                      color: const Color(0xFF9D9D9D),
                      fontSize: responsive.fontSmall,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: responsive.itemSpacing,
                      horizontal: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFE0DCDC)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFFB5457)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: responsive.itemSpacing / 1.2),

                // 자동 로그인 + 찾기
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isAutoLogin,
                          onChanged: (value) {
                            setState(() {
                              _isAutoLogin = value ?? false;
                            });
                          },
                          activeColor: const Color(0xFFFB5457),
                        ),
                        Text(
                          '자동 로그인',
                          style: TextStyle(fontSize: responsive.fontSmall),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '아이디 찾기',
                            style: TextStyle(
                              fontSize: responsive.fontSmall,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '비밀번호 찾기',
                            style: TextStyle(
                              fontSize: responsive.fontSmall,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: responsive.sectionSpacing),

                // 로그인 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFB5457),
                      padding: EdgeInsets.symmetric(
                        vertical: responsive.itemSpacing * 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            '로그인',
                            style: TextStyle(
                              fontSize: responsive.fontBase,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: responsive.sectionSpacing * 1.5),

                // 회원가입
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TermsAgreementPage()),
                    );
                  },
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: responsive.fontSmall,
                      decoration: TextDecoration.underline,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: responsive.sectionSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
