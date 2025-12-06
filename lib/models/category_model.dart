import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';

class CategoryModel {
  String categ_name;
  List<String> english = [];
  List<String> arabic = [];
  bool selected = false;

  CategoryModel(
      {required this.categ_name, required this.arabic, required this.english});
}

// type adapter                                  the class u made the adapter for( is Category model)
class Category_Type_Adapter extends TypeAdapter<CategoryModel> {
  @override
  CategoryModel read(BinaryReader reader) {
    // TODO: implement read   this method should return a categoryModel obj(but broke down)

    return CategoryModel(
        categ_name: reader.readString(),
        english: reader.readStringList(),
        arabic: reader.readStringList());
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;
  // should belong to [0,223] and should be unique for each class (no other type adapter can have the same id)

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    // TODO: implement write
    writer.writeString(obj.categ_name);
    writer.writeStringList(obj.english);
    writer.writeStringList(obj.arabic);
  }
}
