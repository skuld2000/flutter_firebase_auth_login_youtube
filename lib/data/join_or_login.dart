import 'package:flutter/foundation.dart';

//ChangeNotifyProvider 로 전달할 오브젝트 클래스
class JoinOrLogin extends ChangeNotifier {
  bool _isJoin = false; //== true : 가입 / == false : 로그인

  bool get isJoin => _isJoin;
  void toggle() {
    _isJoin = !_isJoin;
    notifyListeners(); //ChangeNotifyProvider 에 통보
  }
}
