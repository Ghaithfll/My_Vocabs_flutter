import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/Custom_widgets/bottom_delete_bar.dart';
import 'package:my_vocabs/Pages/Add_vocabs.dart';
import 'package:my_vocabs/Pages/All_Vocabs.dart';
import 'package:my_vocabs/Pages/Categories.dart';
import 'package:my_vocabs/Pages/Dashboard.dart';
import 'package:my_vocabs/Pages/Test.dart';
import 'package:my_vocabs/Pages/Test_configuration.dart';
import 'package:my_vocabs/controllers/Categs_cont.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:my_vocabs/models/category_model.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  // int BNB_index = 0;
  TextEditingController ans_cont = TextEditingController();
  bool checked = false;
  final categs_cont = Get.put(Categories_Cont());
  final marks_cont = Get.put(Marks_controller());
  int BNB_index = 0;
  List<String> app_bar_title = [
    "Vocabulary Test",
    "Vocab Categories",
    "Dashboard"
  ];
  List<Widget> Body = [
    const Categories_Page(),
    const Test_Configuration_Form(),
    const Dashboard()
  ];

  var my_voc_cont = Get.put(Marks_controller());

  @override
  Widget build(BuildContext context) {
    var bottomBarItems = [
      const BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined), label: "Categories"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.text_increase_sharp), label: "Test"),
      const BottomNavigationBarItem(
          icon: Icon(Icons
              .data_thresholding_outlined), //Icon(Icons.workspace_premium_outlined), // score icon
          label: "Dashboard"),
    ];
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              app_bar_title[BNB_index],
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Body[BNB_index],
          floatingActionButton: BNB_index == 0 //BNB_index == 1
              ? FloatingActionButton(
                  child: Icon(Icons.add_box_outlined),
                  onPressed: () async {
                    TextEditingController categ_name_cont =
                        TextEditingController();
                    bool valid_name = false;
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "Enter The Name Of The New Category",
                          overflow: TextOverflow.fade,
                        ),
                        content: TextField(
                          controller: categ_name_cont,
                          maxLength: 20,
                          onChanged: (value) {
                            for (var categ in Categories) {
                              if (categ.categ_name == value.trim()) {
                                valid_name = false;
                              } else if (value.isNotEmpty) {
                                valid_name = true;
                              }
                            }
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              if (valid_name) {
                                CategoryModel new_categ = CategoryModel(
                                    categ_name: categ_name_cont.text,
                                    arabic: [],
                                    english: []);
                                categs_cont.Add_Category(new_categ);
                                Categories.add(new_categ);
                                Save_Categories_List();
                              } else {
                                String message = "Invalid Value";
                                if (categ_name_cont.text.isNotEmpty) {
                                  message = "Already Existed";
                                }
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(message),
                                    title: Text(
                                      "Error",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "OK",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ))
                                    ],
                                  ),
                                );
                              }
                              // now save categ_List

                              setState(() {});
                            },
                            child: Text("Add",
                                style: TextStyle(color: Colors.blue)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : Container(),
          bottomNavigationBar: //Obx(() =>
              categs_cont.Categs_Select_Mode.value ||
                      marks_cont.marks_edit_mode.value
                  ? Bottom_Delete_Bar()
                  : BottomNavigationBar(
                      backgroundColor: Colors.orange,
                      showUnselectedLabels: false,
                      selectedItemColor: Colors.purple[400],
                      unselectedItemColor:
                          const Color.fromARGB(255, 197, 165, 175),
                      type: BottomNavigationBarType.shifting,
                      selectedLabelStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      iconSize: 27,
                      currentIndex: BNB_index, //BNB_index,
                      onTap: (value) {
                        setState(() {
                          BNB_index = value; //BNB_index = value;
                        });
                      },
                      items: bottomBarItems,
                    )
          //)
          ,
        ));
  }
}
