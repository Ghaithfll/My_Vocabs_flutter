import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_vocabs/Custom_widgets/Vocab.dart';
import 'package:my_vocabs/Pages/Add_vocabs.dart';
import 'package:my_vocabs/controllers/all_voc_cont.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class All_Vocabs extends StatefulWidget {
  All_Vocabs({super.key, required this.cat_index, required this.category});
  CategoryModel category;
  int cat_index;

  @override
  State<All_Vocabs> createState() => _All_VocabsState();
}

class _All_VocabsState extends State<All_Vocabs> {
  List vocabs = [];
  List meanings = [];
  final all_voc_cont = Get.put(All_Voc_Controller());

  @override
  void initState() {
    // TODO: implement initState
    //my_voc_cont.Read_my_vocabs_lists();
    Read_Vocab_Lists(widget.category);
    all_voc_cont.Initialize_cont(
        Eng: widget.category.english, Ar: widget.category.arabic);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    vocabs = widget.category.english;

    meanings = widget.category.arabic;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.category.categ_name,
            style: const TextStyle(),
          ),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        body: Obx(() => Center(
              child: all_voc_cont.Vocabs
                      .isEmpty //since the obx content depends on this line, then this line should be reactive(Rx type to reflect the changes immediately)
                  ? const Text(
                      "Still empty",
                      style: TextStyle(fontSize: 15),
                    )
                  : ListView.builder(
                      itemCount: all_voc_cont.Vocabs.length,
                      itemBuilder: (context, index) => Vocab(
                          meaning: all_voc_cont.Meanings[index],
                          word: all_voc_cont.Vocabs[index]),
                    ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => Add_Vocabs_page(category: widget.category));
          },
          child: const Text(
            "Add Vocabs",
            style: TextStyle(fontSize: 12),
          ),
        ));
  }
}
