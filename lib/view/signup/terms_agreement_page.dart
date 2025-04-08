import 'package:flutter/material.dart';
import 'package:safe_hi/view/signup/signup_form_page.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart'; // 공통 BottomOneButton 임포트

class TermsAgreementPage extends StatefulWidget {
  const TermsAgreementPage({super.key});

  @override
  State<TermsAgreementPage> createState() => _TermsAgreementPageState();
}

class _TermsAgreementPageState extends State<TermsAgreementPage> {
  bool _allAgreeValue = false;
  bool _agreeTerms = false;
  bool _agreePrivacy = false;
  bool _agreeThirdParty = false;

  // 개별 항목 모두 동의되었는지 확인하는 getter
  bool get _allIndividualAgree =>
      _agreeTerms && _agreePrivacy && _agreeThirdParty;

  // 개별 체크 상태에 따라 전체 체크 상태 업데이트
  void _updateOverallCheckbox() {
    setState(() {
      _allAgreeValue = _allIndividualAgree;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            DefaultBackAppBar(title: '약관 동의'),
            const SizedBox(height: 16),
            const Text(
              '서비스 시작 및 가입을 위해\n먼저 아래 약관에 동의해주세요.',
              style: TextStyle(fontSize: 15, color: Color(0xFF433A3A)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // 전체 동의 체크박스
            CheckboxListTile(
              value: _allAgreeValue,
              onChanged: (value) {
                setState(() {
                  _allAgreeValue = value ?? false;
                  // 전체 체크박스 선택 시 모든 항목을 동일하게 설정
                  _agreeTerms = _allAgreeValue;
                  _agreePrivacy = _allAgreeValue;
                  _agreeThirdParty = _allAgreeValue;
                });
              },
              title: const Text(
                '필수 전체 동의',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.red,
            ),
            const Divider(),
            // 개별 체크박스 항목들
            _buildTermItem(
              '(필수) 이용약관 동의',
              _agreeTerms,
              (value) {
                setState(() {
                  _agreeTerms = value ?? false;
                  _updateOverallCheckbox();
                });
              },
            ),
            _buildTermItem(
              '(필수) 개인정보 수집 및 이용동의',
              _agreePrivacy,
              (value) {
                setState(() {
                  _agreePrivacy = value ?? false;
                  _updateOverallCheckbox();
                });
              },
            ),
            _buildTermItem(
              '(필수) 개인정보 제3자 제공 동의',
              _agreeThirdParty,
              (value) {
                setState(() {
                  _agreeThirdParty = value ?? false;
                  _updateOverallCheckbox();
                });
              },
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BottomOneButton(
          buttonText: '다음',
          isEnabled: _allIndividualAgree, // 모든 개별 항목이 동의되어야 활성화
          onButtonTap: () {
            if (_allIndividualAgree) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignupFormPage()),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTermItem(
      String title, bool value, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.red,
    );
  }
}
