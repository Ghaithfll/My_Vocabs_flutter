import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/controllers/all_voc_cont.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Delete_Vocab_Bar extends StatelessWidget {
  Delete_Vocab_Bar({super.key, required this.category});
  CategoryModel category;
  final all_voc = Get.put(All_Voc_Controller());
  @override
  Widget build(BuildContext context) {
    vocab_backup = [];
    meanings_backup = [];
    vocab_backup.insertAll(0, category.english);
    meanings_backup.insertAll(0, category.arabic);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {
              Save_Delete_Vocabs_Process(context);
            },
            child: Text(
              "save",
              style: TextStyle(color: Colors.blue),
            )),
        TextButton(
            onPressed: () {
              Cancel_Delete_Process(all_voc: all_voc, category: category);
            },
            child: Text("cancel", style: TextStyle(color: Colors.blue))),
      ],
    );
  }

  void Save_Delete_Vocabs_Process(BuildContext cont) async {
    category.arabic.clear();
    category.english.clear();
    category.english.insertAll(0, all_voc.Vocabs);
    category.arabic.insertAll(
        0,
        all_voc
            .Meanings); // those lines delivers the delete process to the main stored lists,cuz first time we press del button, the vocabs are deleted from the controller(state-management one/ the visual one)
    await showDialog(
      context: cont,
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
                    Save_Vocab_Lists(category);
                    all_voc.Disable_Delete_Voc_Mode();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.blue),
                  )),
              TextButton(
                  onPressed: () {
                    Cancel_Delete_Process(all_voc: all_voc, category: category);
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
  }
}

void Cancel_Delete_Process(
    {required CategoryModel category, required All_Voc_Controller all_voc}) {
  category.english.clear();
  category.arabic.clear();
  category.english.insertAll(0, vocab_backup);
  category.arabic.insertAll(0, meanings_backup);
  all_voc.Initialize_cont(Eng: vocab_backup, Ar: meanings_backup);
  all_voc.Disable_Delete_Voc_Mode();
}
