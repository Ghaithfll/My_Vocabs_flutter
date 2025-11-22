import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/Pages/Add_vocabs.dart';
import 'package:my_vocabs/Pages/All_Vocabs.dart';
import 'package:my_vocabs/Pages/Categories.dart';
import 'package:my_vocabs/Pages/Dashboard.dart';
import 'package:my_vocabs/Pages/Test.dart';
import 'package:my_vocabs/Pages/Test_configuration.dart';
import 'package:my_vocabs/controllers/BNB_cont.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  // int BNB_index = 0;
  TextEditingController ans_cont = TextEditingController();
  bool checked = false;
  int BNB_index = 0;
  List<String> app_bar_title = [
    "Vocabulary Test",
    "Vocab Categories",
    "Dashboard"
  ];
  List<Widget> Body = [
    const Test_Configuration_Form(),
    const Categories_Page(),
    const Dashboard()
  ];
  final Bnb_cont = Get.put(BnbCont());
  var my_voc_cont = Get.put(Marks_controller());

  @override
  Widget build(BuildContext context) {
    var bottomBarItems = [
      const BottomNavigationBarItem(
          icon: Icon(Icons.text_increase_sharp), label: "Test"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined), label: "Categories"),
      const BottomNavigationBarItem(
          icon: Icon(Icons
              .data_thresholding_outlined), //Icon(Icons.workspace_premium_outlined), // score icon
          label: "Dashboard"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          app_bar_title[Bnb_cont.BNB_index],
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Body[Bnb_cont.BNB_index],
      bottomNavigationBar: //Obx(() =>
          BottomNavigationBar(
        backgroundColor: Colors.orange,
        showUnselectedLabels: false,
        selectedItemColor: Colors.purple[400],
        unselectedItemColor: const Color.fromARGB(255, 197, 165, 175),
        type: BottomNavigationBarType.shifting,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        iconSize: 27,
        currentIndex: Bnb_cont.BNB_index, //BNB_index,
        onTap: (value) {
          setState(() {
            Bnb_cont.BNB_index = value; //BNB_index = value;
          });
        },
        items: bottomBarItems,
      )
      //)
      ,
    );
  }
}
