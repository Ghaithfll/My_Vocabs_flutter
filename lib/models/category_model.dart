import 'package:get/state_manager.dart';

class CategoryModel {
  String categ_name;
  List<String> english = [];
  List<String> arabic = [];

  CategoryModel(
      {required this.categ_name, required this.arabic, required this.english});
}
