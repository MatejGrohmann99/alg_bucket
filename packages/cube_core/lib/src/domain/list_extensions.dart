extension DeepCopy on List<List<List<int>>> {
  List<List<List<int>>> clone() {
    return map(
      (list) => list
          .map(
            (sl) => sl.toList(),
          )
          .toList(),
    ).toList();
  }
}
