import 'package:hive/hive.dart';

class Tst_Mark_Modl {
  int questions_cnt;
  double score;
  String Category_name;

  Tst_Mark_Modl(
      {required this.Category_name,
      required this.questions_cnt,
      required this.score});
}

class Test_Mark_Type_Adapter extends TypeAdapter<Tst_Mark_Modl> {
  @override
  Tst_Mark_Modl read(BinaryReader reader) {
    // TODO: implement read
    return Tst_Mark_Modl(
        Category_name: reader.readString(),
        questions_cnt: reader.readInt(),
        score: reader.readDouble());
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Tst_Mark_Modl obj) {
    // TODO: implement write
    writer.writeDouble(obj.score);
    writer.writeInt(obj.questions_cnt);
    writer.writeString(obj.Category_name);
  }
}
