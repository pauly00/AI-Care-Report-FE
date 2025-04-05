import 'package:flutter/material.dart';
import 'package:safe_hi/view/visit/visit_check2.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';

class Check1 extends StatefulWidget {
  const Check1({super.key});

  @override
  Check1State createState() => Check1State();
}

class Check1State extends State<Check1> {
  final List<String> checklistItems = [
    '우편함이나 집 앞에 전단지, 홍보물, 신문, 우편물이 쌓여있다.',
    '현관, 현관 주변, 문고리 등에 먼지가 쌓여있다.',
    '집 주변에 파리, 구더기 등 벌레가 보이고 악취가 난다.',
    '쓰레기에 술병이 많이 보인다.',
    '집 앞에 미끄러운 곳이 있어 낙상의 위험이 있다.',
  ];

  List<bool> isChecked = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            const DefaultBackAppBar(title: '현장체크'),
            const SizedBox(height: 10),
            // 제목 추가
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '주변 환경 관리',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: checklistItems.asMap().entries.map((entry) {
                    int index = entry.key;
                    String item = entry.value;
                    return _buildChecklistItem(index, item);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BottomOneButton(
          buttonText: '다음',
          onButtonTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Check2()),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChecklistItem(int index, String item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFDD8DA).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Checkbox(
          value: isChecked[index],
          activeColor: const Color(0xFFFB5457),
          onChanged: (bool? value) {
            setState(() {
              isChecked[index] = value ?? false;
            });
          },
        ),
        title: Text(
          item,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
