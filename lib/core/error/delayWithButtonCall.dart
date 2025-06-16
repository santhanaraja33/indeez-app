import 'dart:async';

class Delaywithbuttoncall {
  static void executeAfterDelay(Duration duration, Function function) {
    Future.delayed(duration, function());
  }
}