import 'package:hive/hive.dart';

class Tst_Mark_Modl {
  int questions_cnt;
  double score;
  String Category_name;
  DateTime date;
  bool selected = false;

  Tst_Mark_Modl(
      {required this.Category_name,
      required this.questions_cnt,
      required this.score,
      DateTime? date})
      : date = date ?? DateTime.now();
}

class Test_Mark_Type_Adapter extends TypeAdapter<Tst_Mark_Modl> {
  @override
  Tst_Mark_Modl read(BinaryReader reader) {
    // TODO: implement read
    final category = reader.readString();
    final questions = reader.readInt();
    final score = reader.readDouble();
    final date = DateTime.fromMicrosecondsSinceEpoch(reader.readInt());
    // Older records may not contain the date field. Try to read it,
    // and if not available, fall back to DateTime.now(). This makes
    // the adapter backward-compatible with previously stored data.
    

    return Tst_Mark_Modl(
        Category_name: category,
        questions_cnt: questions,
        score: score,
        date: date);
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Tst_Mark_Modl obj) {
    // TODO: implement write
    // write fields in the same order the reader expects
    writer.writeString(obj.Category_name);
    writer.writeInt(obj.questions_cnt);
    writer.writeDouble(obj.score);
    writer.writeInt(obj.date.microsecondsSinceEpoch);
  }
}
