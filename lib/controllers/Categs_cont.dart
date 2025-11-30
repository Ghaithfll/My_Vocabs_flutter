import 'package:get/get.dart';
import 'package:my_vocabs/models/category_model.dart';

class Categories_Cont extends GetxController {
  RxList<CategoryModel> Categories_List = <CategoryModel>[].obs;
  RxBool Categs_Select_Mode = false.obs;

  void Initialize_Categories_Cont(List<CategoryModel> categs) {
    Categories_List = <CategoryModel>[].obs;
    Categories_List.assignAll(categs);
  }

  void Add_Category(CategoryModel categ) {
    Categories_List.add(categ);
    update();
  }

  void Enable_Select_Mode() {
    Categs_Select_Mode.value = true;
  }

  void Disable_Select_Mode() {
    Categs_Select_Mode.value = false;
  }
}
