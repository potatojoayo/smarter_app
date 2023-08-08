import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/theme/theme.dart';

class CalendarController extends GetxController {
  static CalendarController get to => Get.find();

  final focusedDay = DateTime.now().obs;
  final selectedDay = DateTime.now().obs;

  @override
  onInit() {
    super.onInit();
    load();
  }

  load() async {
    final result = await Client().client.value.query(QueryOptions(
          document: gql(calendarQuery),
          variables: {
            'year': selectedDay.value.year,
            'month': selectedDay.value.month,
          },
        ));

    List<Map<String, dynamic>> auditions = List<Map<String, dynamic>>.from(
        result.data!['myAuditions']['edges'].map((s) => s['node']));

    List<Map<String, dynamic>> absentRequests =
        List<Map<String, dynamic>>.from(result.data!['gymAbsentRequests']);

    List<Map<String, dynamic>> notifications = List<Map<String, dynamic>>.from(
        result.data!['myGymNotifications']['edges'].map((e) => e['node']));

    allEvents.clear();
    events.clear();
    getEvents(auditions, absentRequests, notifications);
  }

  final Map<String, List<Event>> events = <String, List<Event>>{}.obs;
  final allEvents = <Event>[].obs;

  get eventsOfSelectedDay => allEvents
      .where((Event e) => e.date.day == selectedDay.value.day)
      .toList();

  DateTime get yesterday {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day - 1);
  }

  getEvents(auditions, absentRequests, notifications) {
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

    for (var request in absentRequests) {
      final date = DateTime.parse(request['dateAbsent']);
      final day = '${date.year}${date.month}${date.day}';
      final dayEvents = <Event>[];
      final e = Event(
        date: date,
        type: '결석신청',
        contents:
            '${request['student']['classMaster']['name']} ${request['student']['name']} 결석신청\n사유: ${request['absentReason']}',
      );
      dayEvents.add(e);
      allEvents.add(e);
      if (events[day] == null) {
        events.addAll({day: dayEvents});
      } else {
        events[day]?.addAll(dayEvents);
      }
    }

    for (var notification in notifications) {
      if (notification['eventDate'] != null) {
        final date = DateTime.parse(notification['eventDate']);
        final day = '${date.year}${date.month}${date.day}';
        final dayEvents = <Event>[];
        final e = Event(
          date: date,
          type: '알림장',
          contents: '${notification['title']}\n${notification['contents']}',
        );
        dayEvents.add(e);
        allEvents.add(e);
        if (events[day] == null) {
          events.addAll({day: dayEvents});
        } else {
          events[day]?.addAll(dayEvents);
        }
      }
    }
  }

  getColor(Event event) {
    switch (event.type) {
      case '승급':
        return Get.theme.primaryColorDark;
      case '결석신청':
        return Get.theme.colorScheme.error;
      case '알림장':
        return successColor;
    }
  }
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

const calendarQuery = """
  query CalendarQuery(\$after: String \$year: Int \$month: Int){
    myAuditions(first:10 after: \$after year: \$year month: \$month){
      edges{
        node{
          id
          currentLevel{
            name
          }
          nextLevel{
            name
          }
          dateAudition
          state
        }
      }
    }
    gymAbsentRequests(year: \$year month: \$month){
      absentReason
      dateAbsent
      student{
        name
        classMaster{
          name
        }
      }
    }
    myGymNotifications(year: \$year month: \$month){
      totalCount
       pageInfo{
        hasNextPage
        endCursor
       }
      edges{
        node{
          type
          dateCreated
          title
          contents
          sendType
          sendDatetime
          images
          eventDate
          classMaster {
            name
          }
        }
      }
    }
  }
""";
