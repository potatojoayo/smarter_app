import 'package:get/get.dart';

class AuditionCalendarController extends GetxController {
  static AuditionCalendarController get to => Get.find();

  final focusedDay = DateTime.now().obs;
  final selectedDay = DateTime.now().obs;

  final allEvents = <Event>[].obs;
  get eventsOfSelectedDay => allEvents
      .where((Event e) => e.date.day == selectedDay.value.day)
      .toList();

  DateTime get yesterday {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day - 1);
  }

  getEvents(auditions, absentRequests, notifications) {
    allEvents.clear();
    final Map<String, List<Event>> events = {};

    for (var audition in auditions) {
      final date = DateTime.parse(audition['dateAudition']);
      final day = '${date.year}${date.month}${date.day}';
      final dayEvents = <Event>[];
      final e = Event(
        date: DateTime.parse(audition['dateAudition']),
        type: '승급',
        contents:
            '${audition['currentLevel']['name']} -> ${audition['nextLevel']['name']} 승급심사일',
      );
      dayEvents.add(e);
      allEvents.add(e);
      if (events[day] == null) {
        events.addAll({day: dayEvents});
      } else {
        events[day]?.addAll(dayEvents);
      }
    }

    return events;
  }

  getColor(Event event) {
    switch (event.type) {
      case '승급':
        return Get.theme.primaryColorDark;
      case '결석신청':
        return Get.theme.colorScheme.error;
    }
  }

  eventsOfSelectedDate(attendances) {}
}

class Event {
  Event(
      {required this.type,
      required this.contents,
      this.absentReason,
      required this.date});

  final DateTime date;
  final String type;
  final String contents;
  final String? absentReason;

  @override
  toString() {
    return contents;
  }
}
