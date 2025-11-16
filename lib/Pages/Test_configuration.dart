import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_vocabs/Pages/Test.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Test_Configuration_Form extends StatefulWidget {
  const Test_Configuration_Form({super.key});

  @override
  State<Test_Configuration_Form> createState() =>
      _Test_Configuration_FormState();
}

class _Test_Configuration_FormState extends State<Test_Configuration_Form> {
  final formkey = GlobalKey<FormState>();
  var chosen_categ = Categories[0];

  TextEditingController questions_count_cont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(padding: EdgeInsets.all(10)),
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.86,
        child: const Text(
          "Choose Your Test Configurations",
          overflow: TextOverflow.clip,
          style: TextStyle(fontSize: 20),
        ),
      ),
      const Padding(padding: EdgeInsets.all(20)),
      Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.67,
                    child: TextFormField(
                      controller: questions_count_cont,
                      // autofocus: true,
                      decoration: const InputDecoration(
                          //border: InputBorder.none,
                          hintText: "ex: 20",
                          label: Text("Questions Count")),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required";
                        } else if (questions_count_cont.text.isNumericOnly ==
                            false) {
                          return "this should be a numeric value!";
                        } else if (int.parse(questions_count_cont.text) >
                            English_Vocabs.length) {
                          print("Exceed ******************************");
                          return "this value should not exceed ${English_Vocabs.length}";
                        } else if (int.parse(questions_count_cont.text) <= 0) {
                          return "Invalid number";
                        }
                        return null;
                      },
                    )),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Center(
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.67,
                      child: DropdownButtonFormField(
                        value: chosen_categ,
                        decoration:
                            const InputDecoration(label: Text("Vocabs Category")),
                        items: Categories.map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            )).toList(),
                        onChanged: (value) {
                          setState(() {
                            chosen_categ = value!;
                          });
                        },
                      ))),
              /* SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.15,
              ),*/ /*
              IconButton(
                  onPressed: () {
                    List a = [1, 2, 3];
                    List b = a;
                    b[0] = 5;
                    print(
                        "a[0] ${a[0]}"); // list a = b then both pointing to the same obj
                  },
                  icon: Icon(Icons.temple_buddhist_outlined))*/
            ],
          )),
      const Padding(padding: EdgeInsets.all(20)),
      ElevatedButton(
          onPressed: () {
            //  questions_count = questions_count_cont.text;// cast str => int

            if (formkey.currentState!.validate()) {
              //chosen_categ = Categories[0];

              // this souldnt be called everytime
              Shuffle_Vocabs_Lists();
              Get.to(Test_Page(
                  test_category: chosen_categ,
                  questions_count:
                      int.parse(questions_count_cont.text.toString())));
              questions_count_cont.clear();
            }
          },
          child: const Text("Confirm"))
    ]);
  }

  void Shuffle_Vocabs_Lists() {
    print("""BEFORE $English_Vocabs
    $Arabic_Meanings\n""");
//*********************************************** */

    int rand = 0;
    List shuffledIndex = [];
    String temp = "";
    //
    print(shuffledIndex.contains(10));
    for (int i = 0; i < English_Vocabs.length; i++) {
      rand = Random().nextInt(English_Vocabs.length);
/*
      while (i == rand || shuffled_index.contains(rand)) {
        rand = Random().nextInt(English_Vocabs.length);
      }*/
      // swap English elements
      temp = English_Vocabs[i];
      English_Vocabs[i] = English_Vocabs[rand];
      English_Vocabs[rand] = temp;
      // swap Arabic elements
      temp = Arabic_Meanings[i];
      Arabic_Meanings[i] = Arabic_Meanings[rand];
      Arabic_Meanings[rand] = temp;
      // its more random without this line so i removed it
      // shuffled_index.add(rand);
    }

//*********************************************** */
    print("""AFTER $English_Vocabs
   $Arabic_Meanings""");
  }
}
