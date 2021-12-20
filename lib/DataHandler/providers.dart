import 'package:flutter/foundation.dart';

class AppData extends ChangeNotifier{

  int remainingTime = 0;
  void getTime(int timerValue){
    remainingTime = timerValue;
      notifyListeners();
  }


  int getRemainingTime()=> remainingTime;
  updateRemainingTime(){

    remainingTime = remainingTime - 1;
    notifyListeners();
  }
}