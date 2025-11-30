import 'package:get/get.dart';
import 'package:my_vocabs/controllers/Categs_cont.dart';
import 'package:my_vocabs/main.dart';
import 'package:my_vocabs/models/category_model.dart';

List<String> English_Vocabs = [
  "Awkward",
  "Chills",
  "Insect",
  "Staggered",
  "Beat",
  "Orphan",
  "Lie"
];
List<String> Arabic_Meanings = [
  "محرج",
  "قشعريرة",
  "حشرة",
  "تعثر",
  "يهزم",
  "يتيم",
  "يكذب"
];
bool Vocabs_Edit_mode = false;
//List<String> Categories = ["English Level 6", "English Level 7", "My Vocabs"];
List<CategoryModel> Categories = [
  CategoryModel(
      categ_name: "English Level 6",
      arabic: ["عالق", "تقدير", "ازالة"],
      english: ["stuck", "estimate", "eleminate"]),
  CategoryModel(categ_name: "English Level 7", arabic: ["يجادل"], english: ["argue"]),
  CategoryModel(categ_name: "English Level 8", arabic: [], english: []),
 
  CategoryModel(categ_name: "My Vocabs", arabic: [], english: [])
];
int App_Used = 0; // if 0 => new app, else the app is used
/*
List<String> Level_7 = [];
List<String> Level_7_meanings = [];

List<String> Level_6 = ["stuck", "estimate", "eleminate"];
List<String> Level_6_meanings = ["عالق", "تقدير", "ازالة"];*/
int test_starting_index = 0; // store & retrieve

/*  // these 2 lists are moved to the mark_Controller 
List<String> My_vocabs = [];
List<String> My_vocabs_meanings = [];*/

void Save_Vocab_Lists(CategoryModel category) {
  my_box!.put(category.categ_name, category.english);

  my_box!.put(category.categ_name + "_meanings", category.arabic);
  print("================= Vocabs Lists have been Saved Successfully");
  print(category.english);
}

void Read_Vocab_Lists(CategoryModel category) {
  category.english = (my_box!.get(category.categ_name) ?? []);

  category.arabic = (my_box!.get(category.categ_name + "_meanings") ?? []);
  print("================= Vocabs Lists have been Read Successfully");
  print(category.english);
}

//************ initialize app saved lists(store them) */

void Initialize_Application_First_Time() {
  // invoke this to store level 6 & level 7
  App_Used = my_box!.get("App_Used") ?? 0;
  if (App_Used == 0) {
    for (int i = 0; i < Categories.length; i++) {
      Save_Vocab_Lists(Categories[i]);
    }
    App_Used += 5;
    my_box!.put("App_Used", App_Used);
    print("################# App Initialized #############");
    // save Categories list 
    Save_Categories_List();
  }
}

void Read_Categories_List() {
  Categories = (my_box!.get("Categories_List")).cast<CategoryModel>() ?? []; // casting from List<dynamic> => List<CategoryModel>
  print("##### Categories have been read successfully ");
}

void Save_Categories_List() {
  my_box!.put("Categories_List", Categories);
  print("##### Categories have been Saved successfully ");
}

void Save_Test_Mark_List(){

}
void Read_Test_Mark_List(){

}
