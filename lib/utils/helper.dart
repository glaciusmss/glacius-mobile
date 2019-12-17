class Helper {
  static String ifEmptyToNull(String object) {
    if (object?.isEmpty ?? true) {
      return null;
    }

    return object;
  }

  static List buildListByCount(int count) {
    List list = [];
    for (int i = 0; i < count; i++) {
      list.add(i);
    }
    return list;
  }
}
