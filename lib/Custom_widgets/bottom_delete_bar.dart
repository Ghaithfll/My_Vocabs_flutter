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
                              Delete_Selected_Categs();
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
                          },
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  )
                ],
              ),
            );
          },
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        )
      ],
    );
  }

  void Delete_Selected_Categs() {
    List<CategoryModel> To_Delete = [];
    for (var categ in categs_cont.Categories_List) {
      if (categ.selected && categ.categ_name != "My Vocabs") {
        To_Delete.add(categ);
      }
      //categs_cont.Initialize_Categories_Cont(Categories);
    }
    for (var categ in To_Delete) {
      Delete_Category(categ);
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
}
