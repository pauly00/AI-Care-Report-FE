import 'package:flutter/material.dart';
import 'package:safe_hi/repository/conversation_repository.dart';
import 'package:safe_hi/service/conversation_service.dart';

class VisitCheck2ViewModel extends ChangeNotifier {
  // 1) 체크리스트 항목
  final List<String> checklistItems = [
    '집 안에 약 봉투가 계속 쌓여있다.',
    '집 안의 온도와 무관하게 맞지 않는 옷을 입고 있다.',
    '집 주변에 파리, 구더기 등 벌레가 보이고 악취가 난다.',
  ];

  // 2) 체크박스 상태
  List<bool> isCheckedList = [];

  // 3) 상태 변화 (식사, 인지, 의사 기능)
  int? selectedMealCondition;
  int? selectedCognitiveCondition;
  int? selectedCommunicationCondition;

  // 4) 대화 요약 결과 (VisitComment로 넘길) : List<Map<String, dynamic>>
  List<Map<String, dynamic>> conversationSummary = [];

  VisitCheck2ViewModel() {
    // 초기화
    isCheckedList = List.generate(checklistItems.length, (_) => false);
  }

  // 모든 체크가 완료되었는지 확인
  bool get isAllChecked =>
      selectedMealCondition != null &&
      selectedCognitiveCondition != null &&
      selectedCommunicationCondition != null;

  // Repository 호출
  Future<void> fetchConversationSummary() async {
    final repo = ConversationRepository(ConversationService());
    final sections = await repo.fetchConversationSummary();
    // sections: List<ConversationSummarySection>

    // VisitComment가 기대하는 List<Map<String,dynamic>> 형태로 변환
    conversationSummary = sections.map((sec) {
      return {'title': sec.title, 'content': sec.content};
    }).toList();

    notifyListeners();
  }

  //  "다음" 버튼 눌렀을 때 호출 -> 요약 데이터 fetch -> 반환
  Future<List<Map<String, dynamic>>> onNextButtonTap() async {
    await fetchConversationSummary();
    return conversationSummary;
  }

  // 체크박스 업데이트
  void toggleChecklistItem(int index, bool value) {
    isCheckedList[index] = value;
    notifyListeners();
  }

  // 식사, 인지, 의사 기능 상태 업데이트
  void setMealCondition(int? val) {
    selectedMealCondition = val;
    notifyListeners();
  }

  void setCognitiveCondition(int? val) {
    selectedCognitiveCondition = val;
    notifyListeners();
  }

  void setCommunicationCondition(int? val) {
    selectedCommunicationCondition = val;
    notifyListeners();
  }
}
