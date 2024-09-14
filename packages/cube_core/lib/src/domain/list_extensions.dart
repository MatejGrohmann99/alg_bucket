import 'package:cube_core/cube_core.dart';

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

extension AlgToString on List<CM> {
  String toAlgString() => AlgService().convertAlgorithmToString(this);
}

extension AlgListString on List<List<CM>> {
  List<String> toAlgStringList() => map<String>((e) => e.toAlgString()).toList();
}
