String extractNumber(String str) {
  return str.replaceAll(RegExp(r'[^0-9]'), '');
}
