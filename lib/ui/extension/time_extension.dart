extension TimeExtension on DateTime{
  String get formatterDate {
    return "$day / $month / $year";
  }

  String get dayName {
    List<String> day = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"];
    return day[weekday - 1];
  }
}
