import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/Custom_widgets/mark.dart';
import 'package:my_vocabs/Pages/Add_vocabs.dart';
import 'package:my_vocabs/Pages/All_Vocabs.dart';
import 'package:my_vocabs/Pages/Test_configuration.dart';
import 'package:my_vocabs/controllers/Categs_cont.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:my_vocabs/main.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/models/tst_mark_modL.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class Test_Page extends StatefulWidget {
  Test_Page(
      {super.key, required this.questions_count, required this.test_category});
  int questions_count;
  CategoryModel test_category;
  @override
  State<Test_Page> createState() => _Test_PageState();
}

class _Test_PageState extends State<Test_Page> {
  final mark_cont = Get.put(Marks_controller());
  TextEditingController ans_cont = TextEditingController();
  bool Question_checked =
      false; // to check ur answer before going to the next question

  //*  Form related vars
  int current_question = 1;
  String answerState = "";
  List<String> wrongAnswerMessage = [
    "You were close, But the answer is ",
    "Incorrect answer, it means ",
    "Mistakes are part of the way, it is "
  ];
  List<String> CorrectgAnswerMessage = [
    "Great Job!",
    "Well Done , Keep Going!",
    "Nice, You should clack to yourself",
    "Impressive, You are a Goat (not literally))"
  ];

  final my_voc_cont = Get.put(Marks_controller());
  int correct_answers = 0;
  Color button_color = const Color.fromARGB(255, 58, 53, 53);
  Color answer_state_color = Colors.black;
  final tst_form_key = GlobalKey<FormState>();
  // to differentiate between lists
  // according to the categ
  void Save_categ_starting_index(String category) async {
    await my_box!.put("Starting_index_of_categ_$category", test_starting_index);
    print("#####Index Saves successfully  $test_starting_index");
  }

  void Read_categ_starting_index(String category) {
    test_starting_index = my_box!.get("Starting_index_of_categ_$category") ?? 0;
    print("#####Index Read successfully  $test_starting_index");
  }

  @override
  void initState() {
    // TODO: implement initState
    Read_categ_starting_index(widget.test_category.categ_name);
    print("${test_starting_index + current_question - 1}");
    //************** */
    if (test_starting_index + widget.questions_count >= English_Vocabs.length) {
      test_starting_index =
          (English_Vocabs.length - 1) - (widget.questions_count - 1);
      // shuffle method is invoked inside the finish button
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //********************************** */
    return Scaffold(
      body: Center(
        child: Material(
          child: Container(
            color: Colors.orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Write The Meaning Of The Word In Arabic :",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 17.0),
                      child: Text(
                        "( $current_question/${widget.questions_count} )",
                        style: const TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: (Form(
                      key: tst_form_key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${English_Vocabs[test_starting_index + current_question - 1].trim()} ",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Padding(padding: EdgeInsets.all(15)),
                          Text(
                            " means ",
                            style: TextStyle(fontSize: 13),
                          ),
                          const Padding(padding: EdgeInsets.all(15)),
                          SizedBox(
                              width: 160,
                              child: TextFormField(
                                maxLength: 30,
                                style: TextStyle(color: answer_state_color),
                                controller: ans_cont,
                                canRequestFocus: true,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "The answer couldn't be empty";
                                  }
                                  return null;
                                },
                                //  decoration: InputDecoration(border: InputBorder.none),
                              ))
                        ],
                      ))),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Container(
                  child: Text(
                    answerState,
                    style: TextStyle(color: answer_state_color),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                MaterialButton(
                    onPressed: () async {
                      if (tst_form_key.currentState!.validate()) {
                        if (Question_checked == false &&
                            current_question - 1 < English_Vocabs.length) {
                          setState(() {
                            Question_checked = true;

                            // check the answer
                            Check_Answer(
                                Arabic_Meanings[
                                    test_starting_index + current_question - 1],
                                ans_cont.text.trim());
                            /* if (ans_cont.text.trim() ==
                                Arabic_Meanings[test_starting_index +
                                        current_question -
                                        1]
                                    .trim()) {
                              setState(() {
                                answerState = CorrectgAnswerMessage[Random()
                                    .nextInt(CorrectgAnswerMessage.length)];
                                answer_state_color = Colors.green;
                                button_color = Colors.green;
                                correct_answers++;
                              });
                            } else {
                              setState(() {
                                answerState = wrongAnswerMessage[Random()
                                        .nextInt(wrongAnswerMessage.length)] +
                                    Arabic_Meanings[test_starting_index +
                                        current_question -
                                        1];
                                button_color = Colors.red;
                                answer_state_color = Colors.red;
                              });
                            }*/
                          });
                        } else if (current_question != widget.questions_count) {
                          setState(() {
                            // next question
                            Question_checked = false;
                            current_question += 1;
                            ans_cont.clear();
                            answerState = "";

                            answer_state_color = Colors.black;
                            button_color =
                                const Color.fromARGB(255, 58, 53, 53);
                          });
                        } else {
                          // test finish button onpressed
                          double score =
                              (1.0 * correct_answers / widget.questions_count) *
                                  100;
                          // ****** add mark
                          test_starting_index += widget.questions_count;
                          if (test_starting_index >= English_Vocabs.length) {
                            test_starting_index = 0;
                            // shuffle now
                            Shuffle_Vocabs_Lists();
                          }
                          Save_categ_starting_index(
                            widget.test_category.categ_name,
                          );
                          var mark = Tst_Mark_Modl(
                              score: score / 100,
                        //      date: DateTime.now(),
                              questions_cnt: widget.questions_count,
                              Category_name: widget.test_category.categ_name);
                          mark_cont.Add_test_mark_to_Controller(mark);
                          // save mark
                          Marks.add(mark);
                          Save_Test_Mark_List();
                          ///////////
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Nice Try"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "You Scored",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Center(
                                    child: Text(
                                      "${score.toInt()}%",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  /* LinearPercentIndicator(
                                  animation: true,
                                  lineHeight: 20,
                                  percent: score / 100,
                                )*/
                                ],
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                          Get.back();
                                          //   controller.BNB_index = 2;
                                        },
                                        child: const Text(
                                          "OK",
                                          style: TextStyle(color: Colors.blue),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          );

                          //Navigator.pop(context);
                        }
                      }
                    },
                    child: Row(children: [
                      Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: button_color),
                          child: Center(
                              child: Text(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                  Question_checked == false
                                      ? "Check"
                                      : current_question !=
                                              widget.questions_count
                                          ? "Next"
                                          : "Finish")))
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Check_Answer1(String correct_ans, String user_ans) {
    List<String> ans = correct_ans.split("/");
    bool correct = false;
    print("$correct_answers ###################");
    if (correct_ans.contains("\\")) {
      ans = correct_ans.split("\\");
    }
    if (ans.length == 1 && ans[0].trim() == user_ans) {
      setState(() {
        answerState = CorrectgAnswerMessage[
            Random().nextInt(CorrectgAnswerMessage.length)];
        answer_state_color = Colors.green;
        button_color = Colors.green;
        correct = true;
        correct_answers++;
      });
    } else if (ans.length > 1 && correct == false) {
      // the word has more than one meaning

      if (user_ans.contains("/") || user_ans.contains("\\")) {
        List<String> user_long_ans = user_ans.split("/");

        if (user_ans.contains("\\")) {
          user_long_ans = user_ans.split("\\");
        }
        for (var i = 0; i < user_long_ans.length; i++) {
          user_long_ans[i] = user_long_ans[i].trim();
        }
        for (var i = 0; i < ans.length; i++) {
          ans[i] = ans[i].trim();
        }
        bool contains_false = false;
        for (var user_ANS in user_long_ans) {
          for (var anss in ans) {
            if (anss.trim() == user_ANS.trim()) {
              correct_answers++;
              correct = true;

              break;
            }
          }
          if (correct) {
            break;
          }
        }
        for (var anss in user_long_ans) {
          if (ans.contains(anss.trim()) == false) {
            contains_false = true;
            break;
          }
        }
        if (correct) {
          if (contains_false) {
            setState(() {
              answer_state_color = Colors.grey;
              button_color = Colors.grey;
              answerState = "You are close, it only means " + correct_ans;
            });
          } else {
            // the answer has no mistakes
            setState(() {
              answer_state_color = Colors.green;
              button_color = Colors.green;
              answerState = CorrectgAnswerMessage[
                  Random().nextInt(CorrectgAnswerMessage.length)];
            });
          }
        } else {
          // wrong answer
          setState(() {
            answer_state_color = Colors.red;
            button_color = Colors.red;
            answerState =
                wrongAnswerMessage[Random().nextInt(wrongAnswerMessage.length)];
          });
        }
      } else {
        for (var i = 0; i < ans.length; i++) {
          if (user_ans == ans[i].trim()) {
            correct_answers += 1;
            correct = true;
            break;
          }
        }
        if (correct) {
          setState(() {
            answer_state_color = Colors.green;
            button_color = Colors.green;
            answerState = "Correct Answer, it also means ";
            for (var i = 0; i < ans.length; i++) {
              if (ans[i] != user_ans) {
                answerState += ans[i];
              }
              if (ans.length > 2 && i != ans.length - 1) {
                answerState += " / ";
              }
            }
          });
        } else {
          // the answer is wrong
          setState(() {
            answerState = wrongAnswerMessage[
                    Random().nextInt(wrongAnswerMessage.length)] +
                Arabic_Meanings[test_starting_index + current_question - 1];
            button_color = Colors.red;
            answer_state_color = Colors.red;
          });
        }
        print("$correct_answers ###################");
      }
    }
    ;
    print("$correct_answers ###################");
  }

  void Check_Answer(String correctAns, String userAns) {
    List<String> correctList = correctAns.contains("\\")
        ? correctAns.split("\\")
        : correctAns.split("/");

    // Normalize values
    correctList = correctList.map((e) => e.trim()).toList();
    List<String> userList =
        userAns.contains("\\") ? userAns.split("\\") : userAns.split("/");

    userList = userList.map((e) => e.trim()).toList();

    bool matchFound = false;

    //----------------------------------------------------------------
    // CASE 1: only one meaning
    //----------------------------------------------------------------
    if (correctList.length == 1) {
      if (userAns.trim() == correctList[0]) {
        setState(() {
          answerState = CorrectgAnswerMessage[
              Random().nextInt(CorrectgAnswerMessage.length)];
          answer_state_color = Colors.green;
          button_color = Colors.green;
        });
        correct_answers++;
      } else {
        setState(() {
          answer_state_color = Colors.red;
          button_color = Colors.red;
          answerState =
              wrongAnswerMessage[Random().nextInt(wrongAnswerMessage.length)] +
                  " " +
                  Arabic_Meanings[test_starting_index + current_question - 1];
        });
      }
      return;
    }

    //----------------------------------------------------------------
    // CASE 2: word has multiple meanings
    //----------------------------------------------------------------

    // Check if at least ONE meaning is correct
    for (var u in userList) {
      if (correctList.contains(u)) {
        matchFound = true;
        correct_answers++;
        break;
      }
    }

    if (!matchFound) {
      // No meaning matched → completely wrong
      setState(() {
        answer_state_color = Colors.red;
        button_color = Colors.red;
        answerState =
            wrongAnswerMessage[Random().nextInt(wrongAnswerMessage.length)] +
                " " +
                Arabic_Meanings[test_starting_index + current_question - 1];
      });
      return;
    }

    //----------------------------------------------------------------
    // User got at least one correct → check for missing or extra meanings
    //----------------------------------------------------------------
    List<String> missing = [];
    List<String> extra = [];

    // meanings user did NOT write
    for (var c in correctList) {
      if (!userList.contains(c)) missing.add(c);
    }

    // meanings user wrote that are NOT real
    for (var u in userList) {
      if (!correctList.contains(u)) extra.add(u);
    }

    //----------------------------------------------------------------
    // Build response message
    //----------------------------------------------------------------

    if (missing.isEmpty && extra.isEmpty) {
      // PERFECT ANSWER ✔️
      setState(() {
        answer_state_color = Colors.green;
        button_color = Colors.green;
        answerState = CorrectgAnswerMessage[
            Random().nextInt(CorrectgAnswerMessage.length)];
      });
      return;
    }

    // User is close but not perfect
    String msg = "";

    if (missing.isNotEmpty) {
      msg += "Correct, it also means: ${missing.join(' / ')}\n";
    }

    if (extra.isNotEmpty) {
      msg += "Invalid meaning(s): ${extra.join(' / ')}\n";
    }

    setState(() {
      answer_state_color = Colors.grey;
      button_color = Colors.grey;
      answerState = msg.trim();
    });
  }
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
