import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:my_vocabs/controllers/all_voc_cont.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:my_vocabs/main.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Add_Vocabs_page extends StatelessWidget {
  CategoryModel category;
  Add_Vocabs_page({super.key, required this.category});

  final FormKey = GlobalKey<FormState>();
  TextEditingController eng_vocab_cont = TextEditingController();

  TextEditingController arabic_meaning_cont = TextEditingController();
  final myvocab_cont = Get.put(Marks_controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Vocab"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Center(
          child: Form(
        key: FormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              " Add New Vocabs ",
              style: TextStyle(fontSize: 20),
            ),
            const Padding(padding: EdgeInsets.all(15)),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Material(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required!";
                            } else if (eng_vocab_cont.text.trim() == "") {
                              return "can't be empty";
                            }
                            return null;
                          },
                          controller: eng_vocab_cont,
                          decoration: const InputDecoration(
                              label: Text("English"), hintText: "Genius"),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(15)),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required!";
                            } else if (eng_vocab_cont.text.trim() == "") {
                              return "can't be empty";
                            }
                            return null;
                          },
                          controller: arabic_meaning_cont,
                          decoration: const InputDecoration(
                              label: Text("Arabic"), hintText: "عبقري"),
                        ),
                      )
                    ],
                  ),
                )),
            const Padding(padding: EdgeInsets.all(20)),
            MaterialButton(
              hoverColor: Colors.purple[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () async {
                if (FormKey.currentState!.validate()) {
                  // save
                  if (eng_vocab_cont.text.trim().isAlphabetOnly) {
                    // prevent special characters and trim spaces
                    SaveVocab(eng_vocab_cont.text, arabic_meaning_cont.text);
                    eng_vocab_cont.clear();
                    arabic_meaning_cont.clear();
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          "Message",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        content: const Text("Vocab Added Successfully!!!"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Get.back(); // dont forget to refresh the prev page
                              },
                              child: (const Row(
                                // the row here is just to give the button more clickable width
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "OK",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ))),
                        ],
                        actionsAlignment: MainAxisAlignment.center,
                      ),
                    );
                  } else {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          "Error Message",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                            "Please Don't Include Spaces or Special Characters!"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                " OK ",
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    );
                  }
                }
              },
              color: Colors.purple,
              child: Text(
                " Add Vocab ",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  child: const Text(
                    """
note: don't include spaces (ex: 'more than') ,
but you can do in the arabic meaning
(ex:'المقر الرئيسي')""",
                    textAlign: TextAlign.center,
                  ),
                )),
          ],
        ),
      )),
    );
  }

  void SaveVocab(String Eng, String Ar) {
    final cont = Get.put(All_Voc_Controller());
    if (Eng.length > 1 && Ar.length > 1) {
      if (English_Vocabs.length != Arabic_Meanings.length) {
        print(
            "Error , length of Meanings and vocabs lists are not equal ************************************");
      }
/*
      myvocab_cont.My_vocabs.add(Eng);
      myvocab_cont.My_vocabs_meanings.add(Ar);
  */
      // store the 2 lists
      category.english.add(Eng);
      category.arabic.add(Ar);
      Save_Vocab_Lists(category);
      cont.add_voc(ar: Ar, eng: Eng);
      print("${category.english}  /// ${cont.Vocabs}");
      /*    my_box!.put(category.categ_name, category.english);

      my_box!.put(category.categ_name + "_meanings", category.arabic);
*/
      // myvocab_cont.Save_my_vocabs_lists();
      print("================= Saved Successfully");
      //print(myvocab_cont.My_vocabs);
    }
  }
}


/*
1) data storage 
3) shuffle only when need 
4) store the test starting index 
2) input all the vocabs (no storage relationship)
*/
