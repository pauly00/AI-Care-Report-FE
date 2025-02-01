import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // 클릭 시 부모에서 제공한 onTap 호출
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFB5457) : Colors.white,
          border: Border.all(
            color: const Color(0xFFFB5457),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFFFB5457),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategorySelectionScreen extends StatefulWidget {
  final List<String> categories;

  const CategorySelectionScreen({super.key, required this.categories});

  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  title: widget.categories[index],
                  isSelected: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedIndex != -1 ? () {} : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFFB5457),
              ), // 선택된 것이 없을 경우 버튼 비활성화
              child: const Text('다음으로'),
            ),
          ),
        ],
      ),
    );
  }
}
