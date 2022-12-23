import 'dart:math';

import 'package:flutter/cupertino.dart';

enum ExecutionState { idle, loading, success, error }

class AbstractProvider extends ChangeNotifier {
  ExecutionState executionState = ExecutionState.idle;
  int duration = 0;

  setState(ExecutionState executionState) {
    this.executionState = executionState;
    notifyListeners();
  }

  setIdle() {
    setState(ExecutionState.idle);
  }

  setLoading() {
    setState(ExecutionState.loading);
  }

  setSuccess() {
    setState(ExecutionState.success);
  }

  setError() {
    setState(ExecutionState.error);
  }

  bool get isLoading {
    return executionState == ExecutionState.loading;
  }

  delay() async {
    int time = (Random().nextInt(100) + 100).round();
    duration += time;
    await Future.delayed(Duration(milliseconds: time));
  }
}
