import 'package:hive/hive.dart';

class Tst_Mark_Modl {
  int questions_cnt;
  double score;
  String Category_name;
 // DateTime date;
  bool selected = false;
  Tst_Mark_Modl(
      {required this.Category_name,
      required this.questions_cnt,
      required this.score,
    //  required this.date
      });
}

class Test_Mark_Type_Adapter extends TypeAdapter<Tst_Mark_Modl> {
  @override
  Tst_Mark_Modl read(BinaryReader reader) {
    // TODO: implement read
    return Tst_Mark_Modl(
        Category_name: reader.readString(),
        questions_cnt: reader.readInt(),
        score: reader.readDouble(),
     //   date: DateTime.fromMicrosecondsSinceEpoch(reader.readInt())
        );
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Tst_Mark_Modl obj) {
    // TODO: implement write
    writer.writeString(obj.Category_name);
    writer.writeInt(obj.questions_cnt);
    writer.writeDouble(obj.score);
   // writer.writeInt(obj.date.microsecondsSinceEpoch);
  }
}
