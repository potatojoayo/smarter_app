import 'package:timeago/timeago.dart' as timeago;

class KoMessage implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '지금부터';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '후';
  @override
  String lessThanOneMinute(int seconds) => '$seconds초 전';
  @override
  String aboutAMinute(int minutes) => '약 1분 전';
  @override
  String minutes(int minutes) => '$minutes분 전';
  @override
  String aboutAnHour(int minutes) => '약 1시간 전';
  @override
  String hours(int hours) => '$hours시간 전';
  @override
  String aDay(int hours) => '어제';
  @override
  String days(int days) => '$days일 전';
  @override
  String aboutAMonth(int days) => '약 1달 전';
  @override
  String months(int months) => '$months달 전';
  @override
  String aboutAYear(int year) => '약 1년 전';
  @override
  String years(int years) => '$years년 전';
  @override
  String wordSeparator() => ' ';
}
