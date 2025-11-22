import 'package:get/state_manager.dart';

class CategoryModel {
  String categ_name;
  RxList<String> english = [""].obs;
  RxList<String> arabic = [""].obs;

  CategoryModel(
      {required this.categ_name, required this.arabic, required this.english});
}
