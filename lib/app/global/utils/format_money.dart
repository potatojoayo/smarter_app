import 'package:intl/intl.dart';

String formatMoney(int money) {
  return '₩${NumberFormat('###,###,###').format(money)}';
}
