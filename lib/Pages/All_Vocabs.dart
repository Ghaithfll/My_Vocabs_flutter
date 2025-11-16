import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_vocabs/Custom_widgets/Vocab.dart';
import 'package:my_vocabs/Pages/Add_vocabs.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class All_Vocabs extends StatefulWidget {
  All_Vocabs({super.key, required this.cat_index, required this.category});
  String category;
  int cat_index;

  @override
  State<All_Vocabs> createState() => _All_VocabsState();
}

class _All_VocabsState extends State<All_Vocabs> {
  List vocabs = [];
  List meanings = [];
  final my_voc_cont = Get.put(Marks_controller());
  @override
  Widget build(BuildContext context) {
    int x = 0;
    if (x == 0) {
      vocabs = English_Vocabs;
      meanings = Arabic_Meanings;
    } else {
      switch (widget.cat_index) {
        case 0:
          vocabs = Level_7;
          meanings = Level_7_meanings;

          break;
        case 1:
          vocabs = Level_6;
          meanings = Level_6_meanings;
          break;
        case 2:
          vocabs = my_voc_cont.My_vocabs;
          meanings = my_voc_cont.My_vocabs_meanings;
          break;
        default:
          vocabs = ["Not Found"];
          meanings = ["لم يتم ايجاد البيانات"];
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.category,
            style: const TextStyle(),
          ),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        body: Center(
            child: vocabs.isEmpty && my_voc_cont.My_vocabs.isEmpty
                ? const Text(
                    "Still empty",
                    style: TextStyle(fontSize: 15),
                  )
                : widget.category != "My Vocabs"
                    ? ListView.builder(
                        itemCount: vocabs.length,
                        itemBuilder: (context, index) => Vocab(
                            meaning: meanings[index], word: vocabs[index]),
                      )
                    : Obx(
                        () => ListView.builder(
                          itemCount: my_voc_cont.My_vocabs.length,
                          itemBuilder: (context, index) => Vocab(
                              meaning: my_voc_cont.My_vocabs_meanings[index],
                              word: my_voc_cont.My_vocabs[index]),
                        ),
                      )),
        floatingActionButton: widget.category == "My Vocabs"
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(() => Add_Vocabs_page());
                },
                child: const Text(
                  "Add Vocabs",
                  style: TextStyle(fontSize: 12),
                ),
              )
            : Container());
  }
}
