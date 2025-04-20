# SafeHi-FE

'안심하이' 프론트엔드 레포입니다 :)
Flutter 기반의 AI 돌봄 서비스를 제공합니다.

## 🧭 프로젝트 개요
SafeHi는 고령층 및 취약계층을 위한 AI 기반 실시간 음성 상호작용 돌봄 서비스입니다.
</br>본 레포지토리는 Flutter로 구현된 모바일 프론트엔드 앱으로, 
다음과 같은 기능을 포함합니다:

- `음성 기반 방문자와의 실시간 대화`

- `복지 추천 정책 조회`

- `사용자별 맞춤 홈 화면`

- `리포트 자동화 기능`

## ⚙️ SafeHi-FE 프로젝트 설정 가이드

SafeHi 프로젝트를 로컬 환경에서 실행하기 위한 가이드입니다. 아래 과정을 순서대로 따라 주세요.


### **필수 소프트웨어**
1. **[Flutter SDK](https://docs.flutter.dev/get-started/install)** 설치  
   - 권장 버전: **3.13.6 이상**
2. **[Android Studio](https://developer.android.com/studio)** 설치 및 에뮬레이터 설정  
   - AVD Manager를 통해 가상 장치(Emulator)를 생성.
3. **[VS Code](https://code.visualstudio.com/)** 설치  
   - Flutter & Dart 확장 프로그램 설치 필요.


### **설치 및 실행 방법**

1. **프로젝트 클론**
   ```bash
   git clone https://github.com/SAFE-HI/SafeHi-FE.git
   cd SafeHi-FE
   ```
   클론 이후 flutter / dart 설치 이후에 아래와 같이하면 된다.

### flutter doctor 설치
   flutter doctor 친 후에 부족한 것들 설치하면됨

   ```
   flutter doctor --android-licenses
   ```

   이때 android studio 에서 Android SDK - SDK Tools 에서
   Android SDK Build-Tools / Android SDK Command-line Tools / Android SDK Platform-Tools 다운 받으면 됨

   https://www.androidhuman.com/2021-06-02-flutter_android_license_noclassdeffound

2. **의존성 설치**
   ```bash
    flutter pub get
   ```

3. **안드로이드 에뮬레이터 실행**
   - VS Code에서 화면 우측 하단의 장치 선택 메뉴에서 에뮬레이터 선택 후 실행

4. **프로젝트 실행**
   - VS Code에서 main.dart 파일을 열고 F5 키를 눌러 실행. (Start Debugging)


### (25.2) yujin fix - Kotlin 버전 불일치 문제 해결 및 Gradle 설정 업데이트

   ``` bash
   flutter upgrade
   rm -rf ~/.gradle/caches/ # window면 그냥 지우면됨
   flutter clean 
   flutter pub get
   ```

   이렇게되면 성공
   ![alt text](image.png)



### 🧪 빌드 이슈 해결 팁

Kotlin 버전 불일치 또는 Gradle 캐시 오류 발생 시 아래 명령어를 순서대로 실행하세요:

```bash
flutter upgrade
rm -rf ~/.gradle/caches/  # 윈도우는 수동 삭제
flutter clean
flutter pub get
```

---


## 🧩 주요 기능 모듈

| 모듈명                 | 설명                                                                 |
|----------------------|----------------------------------------------------------------------|
| `BottomMenubar`       | 하단 네비게이션 바 UI 구성 및 `NavigationService`를 통한 페이지 라우팅 처리 |
| `TopMenubar`          | 상단 타이틀 및 뒤로가기 버튼 UI 컴포넌트                                   |
| `AudioWebSocketRecorder` | `flutter_sound` 기반 오디오 스트리밍 및 WebSocket 실시간 전송 기능          |
| `WebSocketService`    | WebSocket 연결 및 메시지 송수신 관리 (싱글톤 패턴 적용)                     |
| `HttpService`         | 복지 정책, 리포트 데이터 등 서버 요청 처리 (현재는 더미 데이터 사용 중)       |

---

## 🗂 디렉토리 구조

```
├── model/ # 앱 내 사용되는 데이터 모델 정의 (예: User, Visit 등)
├── provider/ # 전역 상태 관리용 Provider
│ ├── id/ # 사용자 ID, 시나리오 ID 등 식별자 관리
│ └── nav/ # 하단 네비게이션 상태 관리
├── repository/ # API 응답 가공, 캐싱 등 데이터 처리 계층
├── service/ # WebSocket, Audio, HTTP 등 외부 통신 서비스 로직
├── util/ # 공통 유틸리티 (Responsive 처리, 날짜 포맷 등)
├── view/ # 주요 페이지 화면 UI 구성
├── view_model/ # MVVM ViewModel - 페이지별 상태 및 로직 관리
├── widget/ # 재사용 가능한 공통 위젯 모음
│ ├── appbar/ # 상단 앱바 컴포넌트
│ ├── bottom_menubar/ # 하단 네비게이션 바
│ ├── button/ # 공통 버튼 UI
│ ├── card/ # 카드 형태 UI
│ ├── loading/ # 로딩 애니메이션
│ └── search/ # 검색 관련 UI
├── main_screen.dart # 탭 전환 및 초기 진입 화면 구성
├── main.dart # 앱 진입점 (초기화 및 라우팅 처리)
└── README.md # 프로젝트 설명 파일
```
