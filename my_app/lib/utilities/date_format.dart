String getWeekdayAsString(int weekdayNumber) {
  List<String> weekdays = [
    'Mon',
    'Tue',
    'Wednes',
    'Thurs',
    'Fri',
    'Sat',
    'Sun'
  ];
  return weekdays[weekdayNumber - 1];
}

String getMonthAsString(int monthNumber) {
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return months[monthNumber - 1];
}
