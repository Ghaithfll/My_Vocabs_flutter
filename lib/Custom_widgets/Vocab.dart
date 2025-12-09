import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/Pages/Add_vocabs.dart';
import 'package:my_vocabs/controllers/all_voc_cont.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/models/vocab.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Vocab extends StatefulWidget {
  Vocab(
      {super.key,
      required this.categ,
      required this.meaning,
      required this.word,
      required this.all_voc_controller,
      required this.index});
  All_Voc_Controller all_voc_controller;
  String word;
  String meaning;
  int index;
  CategoryModel categ;
  @override
  State<Vocab> createState() => _VocabState();
}

class _VocabState extends State<Vocab> {
  TextEditingController Eng_cont = TextEditingController();

  TextEditingController Ar_cont = TextEditingController();
  bool Delete_Mode = false;
  @override
  Widget build(BuildContext context) {
    Eng_cont.text = widget.word;
    Ar_cont.text = widget.meaning;

    return Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
            onTap: () {
              if (widget.all_voc_controller.Delete_Vocabs_Mode.value == false) {
                Get.to(() => Add_Vocabs_page(
                      category: widget.categ,
                      Edit: true,
                      index: widget.index,
                      vocab: Vocab_model(
                          meaning: widget.meaning, word: widget.word),
                      all_voc_cont: widget.all_voc_controller,
                    ));
              }
            },
            onLongPress: () {
              setState(() {
                widget.all_voc_controller.Enable_Delete_Voc_Mode();
              });
            },
            child: Container(
                // was sizedbox

                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          child: Text(
                            widget.word,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black),
                          )),
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          child: Text(widget.meaning,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black))),
                      widget.all_voc_controller.Delete_Vocabs_Mode.value
                          ? IconButton(
                              onPressed: () {
                                Delete_current_vocab();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                          : Container()
                    ],
                  ),
                ))));
  }

  void Delete_current_vocab() {
    widget.all_voc_controller.Vocabs.removeAt(widget.index);
    widget.all_voc_controller.Meanings.removeAt(widget.index);
  }
}
