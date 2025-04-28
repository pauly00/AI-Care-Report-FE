import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/view_model/user_view_model.dart';
import 'package:safe_hi/view/login/login_page.dart';

import 'package:safe_hi/widget/appbar/default_appbar.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F6),
        body: Column(
          children: [
            DefaultAppBar(title: '마이페이지'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30, // Circle radius for the profile picture
                            backgroundColor: Color(0xFFFFF8F8),
                            child: Text(
                              '🧑🏻‍💼', // Person emoji
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align text to the left
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Vertically center the text
                            children: [
                              Text(
                                '김민수님',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF433A3A),
                                ),
                              ),
                              Text(
                                '대전 동구 마산동',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFB3A5A5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '내 정보 수정',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB3A5A5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Container(
                  //   width: 330,
                  //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: const Color(0xFFFDD8DA).withValues(alpha: 0.5),
                  //         spreadRadius: 2,
                  //         blurRadius: 4,
                  //         offset: const Offset(0, 0),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             '방문',
                  //             style: TextStyle(
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           Text('1년 기준', style: TextStyle(fontSize: 9)),
                  //           SizedBox(height: 5),
                  //           Text(
                  //             '289',
                  //             style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //               color: Color(0xFFFB5457),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       VerticalDivider(
                  //         color: Colors.grey,
                  //         thickness: 1,
                  //         width: 30, // Increased space between the columns
                  //       ),
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             '방문',
                  //             style: TextStyle(
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           Text('한 달 기준', style: TextStyle(fontSize: 9)),
                  //           SizedBox(height: 5),
                  //           Text(
                  //             '32',
                  //             style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //               color: Color(0xFFFB5457),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       VerticalDivider(
                  //         color: Colors.grey,
                  //         thickness: 1,
                  //         width: 30, // Increased space between the columns
                  //       ),
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             '담당 가구',
                  //             style: TextStyle(
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           Text('', style: TextStyle(fontSize: 9)),
                  //           SizedBox(height: 5),
                  //           Text(
                  //             '11',
                  //             style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //               color: Color(0xFFFB5457),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 30,
                              color: Color(0xFFFB5457),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '고객센터',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF433A3A),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(0xFFB3A5A5),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.document_scanner,
                              size: 30,
                              color: Color(0xFFFB5457),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '공지사항',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF433A3A),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(0xFFB3A5A5),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.chat,
                              size: 30,
                              color: Color(0xFFFB5457),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '자주 묻는 질문',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF433A3A),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(0xFFB3A5A5),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.settings,
                              size: 30,
                              color: Color(0xFFFB5457),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '약관 및 동의',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF433A3A),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(0xFFB3A5A5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 130),
                  Container(
                    width: 330,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFDD8DA).withValues(alpha: 0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the app settings screen
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.settings,
                                size: 25,
                                color: Color(0xFFB3A5A5),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '앱 설정',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFB3A5A5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 30, // Adjust the space between the items
                        ),
                        GestureDetector(
                          onTap: () async {
                            // 로그아웃 로직 실행
                            final userVM = Provider.of<UserViewModel>(context,
                                listen: false);
                            await userVM.logout();

                            // 로그인 화면으로 이동
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()),
                              (route) => false, // 이전 모든 화면 제거
                            );
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.logout,
                                  size: 25, color: Color(0xFFB3A5A5)),
                              SizedBox(width: 10),
                              Text(
                                '로그아웃',
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xFFB3A5A5)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
