class ListUtils{
  bool isEqualsAllListElements(List<dynamic> list, List<dynamic> list2) {
    if (list.length != list2.length) {
      return false;
    }

    for (int i = 0; i < list.length; i++) {
      if (list[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }
}