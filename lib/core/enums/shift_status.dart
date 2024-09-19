enum ShiftStatus {
  active,
  inactive,
  scheduled;

  
  String toJson() => name;
  static ShiftStatus fromJson(String json) => values.byName(json);
}
