import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/Pages/All_Vocabs.dart';
import 'package:my_vocabs/controllers/Categs_cont.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Category_Ui extends StatefulWidget {
  Category_Ui({super.key, required this.categ});
  CategoryModel categ;
  static bool Select_Mode = false;
  @override
  State<Category_Ui> createState() => _Category_UiState();
}

class _Category_UiState extends State<Category_Ui> {
  
  final categs_cont = Get.put(Categories_Cont());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (categs_cont.Categs_Select_Mode.value == true) {
          setState(() {
            widget.categ.selected = !widget.categ.selected;
          });
        } else {
          Get.to(() => All_Vocabs(
                category: widget.categ,
              ));
        }
      }, // pop scope to end select mode
      onLongPress: () {
        setState(() {});
        categs_cont.Enable_Select_Mode();
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.purple, borderRadius: BorderRadius.circular(20)),
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    widget.categ.categ_name,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                categs_cont.Categs_Select_Mode.value
                    ? Checkbox(
                        value: widget.categ.selected,
                        onChanged: (value) {
                          setState(() {
                            widget.categ.selected = value!;
                          });
                        },
                      )
                    : Container()
              ],
            )),
      ),
    );
  }
}
