const days = ['월', '화', '수', '목', '금', '토', '일'];
String getDay(int day) {
  return days[day];
}

int getDayCode(String day) {
  return days.indexOf(day);
}
