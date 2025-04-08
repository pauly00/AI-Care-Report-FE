import 'package:flutter/material.dart';
import 'package:safe_hi/view/signup/terms_agreement_page.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart'; // BottomOneButton import

class RoleSelectPage extends StatefulWidget {
  const RoleSelectPage({super.key});

  @override
  State<RoleSelectPage> createState() => _RoleSelectPageState();
}

class _RoleSelectPageState extends State<RoleSelectPage> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                '역할을 선택해주세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '안심하이는 여러분의 역할에 맞춰 \n더 쉽고 정확한 관리를 도와드려요.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              _buildRoleOption('기관 / 지자체', '👨‍💼👩‍💼'),
              const SizedBox(height: 16),
              _buildRoleOption('동행매니저', '🙋‍♂️🙋‍♀️'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BottomOneButton(
          buttonText: '다음',
          isEnabled: _selectedRole != null, // ✅ 역할이 선택됐을 때만 버튼 활성화
          onButtonTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TermsAgreementPage()),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRoleOption(String role, String emoji) {
    final isSelected = _selectedRole == role;

    String subText;
    if (role == '기관 / 지자체') {
      subText = '기관·지자체 관리자님께 꼭 맞춘 서비스예요.\n현재 한전MCS와 지자체에서 사용 중이에요!';
    } else {
      subText = '동행매니저님이 기록과 분석을\n쉽게 관리할 수 있도록 도와드릴게요!';
    }

    return GestureDetector(
      onTap: () {
        setState(() => _selectedRole = role);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFEDED) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFFEB5C5C) : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Icon(
                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                color: isSelected ? const Color(0xFFEB5C5C) : Colors.grey,
              ),
            ),
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 6),
            Text(role, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              subText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
