import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/Custom_widgets/Category_ui.dart';
import 'package:my_vocabs/Pages/All_Vocabs.dart';
import 'package:my_vocabs/controllers/Categs_cont.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Categories_Page extends StatefulWidget {
  const Categories_Page({super.key});

  @override
  State<Categories_Page> createState() => _Categories_PageState();
}

class _Categories_PageState extends State<Categories_Page> {
  final categs_cont = Get.put(Categories_Cont());
  @override
  void initState() {
    // TODO: implement initState
    Read_Categories_List();
    categs_cont.Initialeze_Categories_Cont(Categories);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Category_Ui(
                              categ: categs_cont.Categories_List[index]));
                    },
                    itemCount: categs_cont.Categories_List.length,
                  )),
            )
          ],
        ));
  }
}
