import 'package:get/get.dart';
import 'package:my_vocabs/models/category_model.dart';

class Categories_Cont extends GetxController {
  RxList<CategoryModel> Categories_List = <CategoryModel>[].obs;

  void Initialeze_Categories_Cont(List<CategoryModel> categs) {
    Categories_List.assignAll(categs);
    update();
  }
  void Add_Category(CategoryModel categ) {
    Categories_List.add(categ);
    update();
  }
}
