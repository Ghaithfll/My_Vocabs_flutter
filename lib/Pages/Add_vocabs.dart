import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/controllers/all_voc_cont.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/models/vocab.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Add_Vocabs_page extends StatelessWidget {
  CategoryModel category;
  Add_Vocabs_page(
      {super.key,
      required this.index,
      this.vocab,
      required this.category,
      required this.all_voc_cont,
      this.Edit});
  bool? Edit = false;
  Vocab_model? vocab;
  int index;
  All_Voc_Controller all_voc_cont;
  final FormKey = GlobalKey<FormState>();
  TextEditingController eng_vocab_cont = TextEditingController();
  String button_text = " Add Vocab ";
  TextEditingController arabic_meaning_cont = TextEditingController();
  final myvocab_cont = Get.put(Marks_controller());
  String title = " Add New Vocabs ";
  @override
  Widget build(BuildContext context) {
    if (vocab != null) {
      eng_vocab_cont.text = vocab!.word;
      arabic_meaning_cont.text = vocab!.meaning;
      Edit = true; // useless line
      title = "Edit Vocab";
      button_text = "    Save    ";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Center(
          child: Form(
        key: FormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
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
                              label: Text("English"),
                              hintText: "Word",
                              hintStyle: TextStyle(color: Colors.grey)),
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
                              label: Text("Arabic"),
                              hintText: "meaning_1/meaning_2",
                              hintStyle: TextStyle(
                                  //fontWeight: FontWeight.w100,
                                  color: Colors.grey)),
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
              onPressed: () {
                print("#######   Hii   #######");
                if (Edit == null) {
                  Add_Vocab_Button_On_Pressed(context);
                } else if (Edit == true) {
                  Add_Vocab_Button_On_Pressed(context, edit: true);
                }
              },
              color: Colors.purple,
              child: Text(
                button_text,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(padding: const EdgeInsets.all(8), child: Container()),
          ],
        ),
      )),
    );
  }

  void Add_New_Vocab(String Eng, String Ar) {
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
      cont.add_voc(ar: Ar, eng: Eng); // state management
      print("${category.english}  /// ${cont.Vocabs}");
      /*    my_box!.put(category.categ_name, category.english);

      my_box!.put(category.categ_name + "_meanings", category.arabic);
*/
      // myvocab_cont.Save_my_vocabs_lists();
      print("================= Saved Successfully");
      //print(myvocab_cont.My_vocabs);
    }
  }

  void Add_Vocab_Button_On_Pressed(BuildContext cont,
      {bool edit = false}) async {
    String save_message = "Vocab Added Successfully!!!";
    if (edit == true) {
      save_message = "Vocab Edited Successfully!!!";
    }
    if (FormKey.currentState!.validate()) {
      // save
      if (eng_vocab_cont.text.trim() != "") {
        // prevent special characters and trim spaces
        if (edit == true && index >= 0) {
          category.arabic[index] = arabic_meaning_cont.text;
          category.english[index] = eng_vocab_cont.text;
          // edit controller
          all_voc_cont.Vocabs[index] = eng_vocab_cont.text;
          all_voc_cont.Meanings[index] = arabic_meaning_cont.text;
          // save
          Save_Vocab_Lists(category);
          print("###########  vocab edited successfully!!!  #####");
        } else {
          // add new vocab
          Add_New_Vocab(
              eng_vocab_cont.text.trim(), arabic_meaning_cont.text.trim());
        }
        eng_vocab_cont.clear();
        arabic_meaning_cont.clear();
        await showDialog(
          context: cont,
          builder: (context) => AlertDialog(
            icon: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            title: const Text(
              "Message",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            content: Text(save_message),
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
          context: cont,
          builder: (context) => AlertDialog(
            icon: Icon(Icons.error_outline_outlined, color: Colors.red),
            title: const Text(
              "Error Message",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            content: const Text("The Value Can't Be Empty!"),
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
  }
}

/*
1) data storage 
3) shuffle only when need 
4) store the test starting index 
2) input all the vocabs (no storage relationship)
*/
