String capitalize(String? string) {
  if (string == null || string.isEmpty) {
    return '';
  }

  String first = string[0].toUpperCase();
  String rest = string.substring(1);
  return first + rest;
}
