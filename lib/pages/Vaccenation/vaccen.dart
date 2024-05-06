class Vaccens {
  final String name;
  bool isDone;
  Vaccens({required this.name, this.isDone = false});

  void doneChange() {
    isDone = !isDone;
  }
}
