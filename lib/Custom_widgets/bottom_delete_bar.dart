import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/controllers/Categs_cont.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/models/tst_mark_modL.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Bottom_Delete_Bar extends StatelessWidget {
  Bottom_Delete_Bar({super.key});
  final categs_cont = Get.put(Categories_Cont());
  final marks_cont = Get.put(Marks_controller());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            await showDialog(
              barrierDismissible: false, // tap outside the dialog wont close it
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  "Delete Confirmation",
                  style: TextStyle(color: Colors.red),
                ),
                content: Text("Are You Sure?"),
                actions: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            if (categs_cont.Categs_Select_Mode.value) {
                              Delete_Selected_Categs(context);
                              categs_cont.Disable_Select_Mode();
                            } else if (marks_cont.marks_edit_mode.value) {
                              Delete_Selected_Marks();
                              marks_cont.Disable_Mark_Edit_Mode();
                            }
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.blue),
                          )),
                      TextButton(
                          onPressed: () {
                            marks_cont.Disable_Mark_Edit_Mode();
                            categs_cont.Disable_Select_Mode();
                            Navigator.pop(context);
                            categs_cont.My_categs_selected = false;
                          },
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  )
                ],
              ),
            ); // after the dialog closes
            print(categs_cont.My_categs_selected);
            if (categs_cont.My_categs_selected) {
              showDialog_Method(
                  "Category 'My Vocabs' can't be deleted! Its The application name 🙂",
                  context);
              categs_cont.Get_Categ_By_Name("My Vocabs").selected = false;
            }
          },
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        )
      ],
    );
  }

  void Delete_Selected_Categs(BuildContext context) async {
    List<CategoryModel> To_Delete = [];
    bool my_vocabs_is_selected = false;
    for (var categ in categs_cont.Categories_List) {
      if (categ.selected && categ.categ_name != "My Vocabs") {
        To_Delete.add(categ);
      } else if (categ.categ_name == "My Vocabs" && categ.selected) {
        my_vocabs_is_selected = true;
      }
      //categs_cont.Initialize_Categories_Cont(Categories);
    }

    for (var categ in To_Delete) {
      Delete_Category(categ);
    }

    if (categs_cont.Get_Categ_By_Name("My Vocabs").selected) {
      categs_cont.My_categs_selected = true;
    }

    print("${To_Delete.length} Categories have been deleted");
  }

  void Delete_Selected_Marks() {
    List<Tst_Mark_Modl> To_Delete = [];
    for (var mark in Marks) {
      if (mark.selected) {
        To_Delete.add(mark);
      }
    }
    for (var mark in To_Delete) {
      marks_cont.marks.remove(mark);
      Marks.remove(mark);
    }
    Save_Test_Mark_List(); // now those marks were deleted
    //marks_cont.Read_Marks_From_marks_List(); supposed
    print("${To_Delete.length} Marks have been deleted");
  }

  void showDialog_Method(String content_text, BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Message",
          style: TextStyle(color: Colors.blue),
        ),
        icon: Icon(Icons.error_outline),
        content: Text(
          content_text,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "OK",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
