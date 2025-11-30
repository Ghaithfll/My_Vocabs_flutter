import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/controllers/Categs_cont.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Bottom_Delete_Bar extends StatelessWidget {
  Bottom_Delete_Bar({super.key});
  final categs_cont = Get.put(Categories_Cont());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
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

              categs_cont.Disable_Select_Mode();
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ))
      ],
    );
  }
}
