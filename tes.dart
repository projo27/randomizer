void main() {
  print("gundul ${DateTime.now().millisecondsSinceEpoch}");
  print(
      "gundul ${DateTime.now().add(Duration(days: 1, minutes: 39)).millisecondsSinceEpoch}");
  print("${DateTime.now() == DateTime.now()}");
}
