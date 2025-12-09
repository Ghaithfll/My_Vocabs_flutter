import 'package:get/get.dart';
import 'package:my_vocabs/controllers/Categs_cont.dart';
import 'package:my_vocabs/main.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/models/tst_mark_modL.dart';

bool Categories_Select_Mode = false;
//bool Delete_Vocabs_Mode = false;

List<String> vocab_backup = [];
List<String> meanings_backup = [];
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
  CategoryModel(
      categ_name: "English Level 7", arabic: ["يجادل"], english: ["argue"]),
  CategoryModel(
      categ_name: "English Level 8",
      arabic: level8_meaning,
      english: level8_voc),
  CategoryModel(categ_name: "My Vocabs", arabic: [], english: [])
];

List<String> level8_voc = [
  "Lethal",
  "Proposal",
  "Panacreatic cancer",
  "Perseverance",
  "Grand prize",
  "Epidemic",
  "Election",
  "Assassination",
  "Engineering fair",
  "Prestigious award",
  "Innovator",
  "Contestant",
  "Encourage",
  "Participated",
  "get along with",
  "cut down on sweets",
  "",
];

List<String> level8_meaning = [
  "قاتل/مميت",
  "عرض/اقتراح",
  "سرطان البنكرياس",
  "مثابرة",
  "الجائزة الكبرى",
  "وباء",
  "انتخاب",
  "اغتيال/قتل",
  "معرض الهندسة",
  "جائزة مرموقة",
  "مبتكر",
  "متسابق",
  "يشجع",
  "شارك",
  "ينسجم مع",
  "التقليل من الحلويات",
  "",
];
int App_Used = 0; // if 0 => new app, else the app is used
/*
List<String> Level_7 = [];
List<String> Level_7_meanings = [];

List<String> Level_6 = ["stuck", "estimate", "eleminate"];
List<String> Level_6_meanings = ["عالق", "تقدير", "ازالة"];*/
int test_starting_index = 0; // store & retrieve

List<Tst_Mark_Modl> Marks = [];

void Save_Vocab_Lists(CategoryModel category)  {
   my_box!.put(category.categ_name, category.english);

   my_box!.put(category.categ_name + "_meanings", category.arabic);
  print("================= Vocabs Lists have been Saved Successfully");
  print(category.english);
}

void Read_Vocab_Lists(CategoryModel category)  {
  category.english =  (my_box!.get(category.categ_name) ?? []);

  category.arabic =
       (my_box!.get(category.categ_name + "_meanings") ?? []);
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

void Read_Categories_List()  {
  App_Used =  my_box!.get("App_Used") ?? 0;
  print(App_Used);
  if (App_Used != 0) {
    var data =  my_box!.get("Categories_List");
    Categories = (data as List?)?.cast<CategoryModel>() ?? [];
    print("##### Categories have been read successfully ");
  }
  print(App_Used);
}

void Save_Categories_List() {
  my_box!.put("Categories_List", Categories);
  print("##### Categories have been Saved successfully ");
}

final categ_cont = Get.put(Categories_Cont());
void Delete_Category(CategoryModel categ) async {
  if (categ.categ_name != "My Vocabs") {
    await my_box!.delete(categ.categ_name);
    await my_box!.delete(
        categ.categ_name + "_meanings"); // delete the lists of the categ

    Categories.remove(categ);
    categ_cont.Categories_List.remove(categ);
  }
  Save_Categories_List();
}

void Save_Test_Mark_List()  {
   my_box!.put("Test_Mark_List", Marks);
  print("Marks have been Saved successfully");
}

void Delete_Test_Mark_List()  {
  my_box!.delete("Test_Mark_List");
}

void Read_Test_Mark_List()  {
  var data = my_box!.get("Test_Mark_List");
  Marks = (data as List?)?.cast<Tst_Mark_Modl>() ?? [];
  print("Marks have been Read successfully");
}

class Dont_read_every_time {
  bool categories_read = false;
  bool marks_read = false;
}
