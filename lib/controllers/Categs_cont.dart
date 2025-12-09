import 'package:get/get.dart';
import 'package:my_vocabs/models/category_model.dart';

class Categories_Cont extends GetxController {
  RxList<CategoryModel> Categories_List = <CategoryModel>[].obs;
  RxBool Categs_Select_Mode = false.obs;
  bool My_categs_selected = false;
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
    for (var categ in Categories_List) {
      if (categ.selected) {
        categ.selected = false;
      }
    }
    
  }

  CategoryModel Get_Categ_By_Name(String name) {
    for (var cat in Categories_List) {
      if (cat.categ_name == name) {
        return cat;
      }
    }
    return CategoryModel(categ_name: "Not Found", arabic: [], english: []);
  }
}
