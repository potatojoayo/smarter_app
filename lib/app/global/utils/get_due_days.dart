int getDueDate() {
  final now = DateTime.now();
  DateTime due = DateTime(now.year, now.month, 25);
  int leftDays = due.day - now.day;
  if (leftDays < 0) {
    due = DateTime(now.year, now.month + 1, 25);
    leftDays = due.day - now.day;
  }
  return leftDays;
}
