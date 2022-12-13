import 'package:flutter/cupertino.dart';

enum ExecutionState { idle, loading, success, error }

class AbstractProvider extends ChangeNotifier {
  ExecutionState executionState = ExecutionState.idle;

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
}
