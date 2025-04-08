import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_hi/main_screen.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';

class SignupFormPage extends StatefulWidget {
  const SignupFormPage({super.key});

  @override
  State<SignupFormPage> createState() => _SignupFormPageState();
}

class _SignupFormPageState extends State<SignupFormPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthController = TextEditingController();
  DateTime? _selectedBirthDate;

  bool _isEmailChecked = false;
  String _gender = '남';
  bool _isObscurePassword = true;
  bool _isObscureConfirm = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _birthController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _isEmailChecked &&
        _validateEmail(_emailController.text) &&
        _validatePassword(_passwordController.text) == null &&
        _passwordController.text == _confirmPasswordController.text &&
        _nameController.text.isNotEmpty &&
        _validatePhoneNumber(_phoneController.text) &&
        _birthController.text.isNotEmpty;
  }

  String? _validatePassword(String value) {
    String pattern =
        r'^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,15}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return '비밀번호를 입력하세요';
    } else if (value.length < 8) {
      return '비밀번호는 8자리 이상이어야 합니다';
    } else if (!regExp.hasMatch(value)) {
      return '특수문자, 문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordMatch =
        _passwordController.text == _confirmPasswordController.text;
    final passwordError = _validatePassword(_passwordController.text);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultBackAppBar(title: '회원 가입'),
              const SizedBox(height: 16),
              _buildEmailField(),
              if (_isEmailChecked && _validateEmail(_emailController.text))
                _helperText('사용 가능한 이메일입니다.'),
              if (_isEmailChecked && !_validateEmail(_emailController.text))
                _helperText('올바른 이메일 형식이 아닙니다.', isError: true),
              _buildPasswordField(
                  '비밀번호', _passwordController, _isObscurePassword, () {
                setState(() => _isObscurePassword = !_isObscurePassword);
              }),
              if (passwordError != null)
                _helperText(passwordError, isError: true),
              _buildPasswordField(
                  '비밀번호 확인', _confirmPasswordController, _isObscureConfirm, () {
                setState(() => _isObscureConfirm = !_isObscureConfirm);
              }),
              if (_passwordController.text.isNotEmpty &&
                  _confirmPasswordController.text.isNotEmpty)
                _helperText(
                  passwordMatch ? '비밀번호가 일치합니다.' : '비밀번호가 일치하지 않습니다.',
                  isError: !passwordMatch,
                ),
              _buildTextField(label: '이름', controller: _nameController),
              _buildTextField(
                label: '전화번호',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                hintText: '예시) 010-1234-5678',
              ),
              if (_phoneController.text.isNotEmpty &&
                  !_validatePhoneNumber(_phoneController.text))
                _helperText('전화번호 형식이 올바르지 않습니다.', isError: true),
              _buildBirthField(),
              const SizedBox(height: 16),
              _buildGenderSelection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BottomOneButton(
          buttonText: '다음',
          isEnabled: _isFormValid,
          onButtonTap: () {
            if (_isFormValid) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainScreen()),
              );
            }
          },
        ),
      ),
    );
  }

  bool _validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool _validatePhoneNumber(String phone) {
    return RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(phone);
  }

  Widget _buildEmailField() {
    return _buildTextField(
      label: '이메일',
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      suffixIcon: TextButton(
        onPressed: () => setState(() => _isEmailChecked = true),
        child: const Text('중복확인', style: TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller,
      bool isObscure, VoidCallback toggle) {
    return _buildTextField(
      label: label,
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      obscure: isObscure,
      suffixIcon: IconButton(
        onPressed: toggle,
        icon: Icon(
          isObscure
              ? FontAwesomeIcons.solidEyeSlash
              : FontAwesomeIcons.solidEye,
          color: Theme.of(context).hintColor,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffixIcon,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText(label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: const Color(0xFFF9F6F6),
            filled: true,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFEBE7E7)),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFEBE7E7), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBirthField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText('생년월일'),
        const SizedBox(height: 6),
        TextField(
          controller: _birthController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'YYYY-MM-DD',
            fillColor: const Color(0xFFF9F6F6),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFEBE7E7)),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFEBE7E7), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onTap: () async {
            FocusScope.of(context).unfocus();
            final now = DateTime.now();
            final picked = await showDatePicker(
              context: context,
              initialDate: _selectedBirthDate ?? DateTime(now.year - 20),
              firstDate: DateTime(1900),
              lastDate: now,
            );
            if (picked != null) {
              setState(() {
                _selectedBirthDate = picked;
                _birthController.text = _formatDate(picked);
              });
            }
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText('성별'),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildRadioButton('남'),
            const SizedBox(width: 12),
            _buildRadioButton('여'),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioButton(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _gender,
          onChanged: (val) => setState(() => _gender = val!),
          activeColor: Colors.red,
        ),
        Text(value),
      ],
    );
  }

  Widget _buildLabelText(String label) {
    return Text.rich(
      TextSpan(
        text: label,
        children: const [
          TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  Widget _helperText(String message, {bool isError = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            isError ? Icons.close : Icons.check,
            size: 16,
            color: isError ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 4),
          Text(
            message,
            style: TextStyle(
              color: isError ? Colors.red : Colors.green,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
