import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/Custom_widgets/mark.dart';
import 'package:my_vocabs/Pages/Add_vocabs.dart';
import 'package:my_vocabs/Pages/All_Vocabs.dart';
import 'package:my_vocabs/Pages/Test_configuration.dart';
import 'package:my_vocabs/controllers/BNB_cont.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:my_vocabs/models/tst_mark_modL.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class Test_Page extends StatefulWidget {
  Test_Page(
      {super.key, required this.questions_count, required this.test_category});
  int questions_count;
  String test_category;
  @override
  State<Test_Page> createState() => _Test_PageState();
}

class _Test_PageState extends State<Test_Page> {
  final mark_cont = Get.put(Marks_controller());
  TextEditingController ans_cont = TextEditingController();
  bool Question_checked =
      false; // to check ur answer before going to the next question
  final controller = Get.put(BnbCont());
  //*  Form related vars
  int current_question = 1;
  String answerState = "";
  List<String> wrongAnswerMessage = [
    "You were close, But the answer is ",
    "Incorrect answer, it means "
  ];
  List<String> CorrectgAnswerMessage = [
    "Great Job!",
    "Well Done , Keep Going!",
    "Nice, You should clack to yourself",
    "Impressive, You are a Goat (not literally))"
  ];

  int correct_answers = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  child: (Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${English_Vocabs[current_question - 1]} :",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Padding(padding: EdgeInsets.all(15)),
                      SizedBox(
                          width: 160,
                          child: TextFormField(
                            controller: ans_cont,
                            canRequestFocus: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The answer couldn't be empty";
                              }
                              return null;
                            },
                            //  decoration: InputDecoration(border: InputBorder.none),
                          ))
                    ],
                  ))),
              const Padding(padding: EdgeInsets.all(20)),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (Question_checked == false &&
                          current_question - 1 < English_Vocabs.length) {
                        setState(() {
                          Question_checked = true;

                          // check the answer
                          if (ans_cont.text.trim() ==
                              Arabic_Meanings[current_question - 1]) {
                            setState(() {
                              answerState = CorrectgAnswerMessage[Random()
                                  .nextInt(CorrectgAnswerMessage.length)];
                              correct_answers++;
                            });
                          } else {
                            setState(() {
                              answerState = wrongAnswerMessage[Random()
                                      .nextInt(wrongAnswerMessage.length)] +
                                  Arabic_Meanings[current_question - 1];
                            });
                          }
                        });
                      } else if (current_question != widget.questions_count) {
                        setState(() {
                          // next question
                          Question_checked = false;
                          current_question += 1;
                          ans_cont.clear();
                          answerState = "";
                        });
                      } else {
                        // test finish button onpressed
                        double score =
                            (1.0 * correct_answers / widget.questions_count) *
                                100;
                        // ****** add mark
                        var mark = Tst_Mark_Modl(
                            score: score / 100,
                            questions_cnt: widget.questions_count,
                            Category: widget.test_category);
                        mark_cont.marks.add(mark);

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
                    },
                    child: Text(Question_checked == false
                        ? "Check"
                        : current_question != widget.questions_count
                            ? "Next"
                            : "Finish")),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              Container(
                child: Text(answerState),
              )
            ],
          ),
        ),
      ),
    );
  }
}
