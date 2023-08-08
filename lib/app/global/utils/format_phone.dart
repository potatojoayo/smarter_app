String formatPhone(String phone) {
  try {
    return '${phone.substring(0, 3)} - ${phone.substring(3, 7)} - ${phone.substring(7, 11)}';
  } catch (_) {
    return '';
  }
}
