import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:my_vocabs/Pages/home.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:path_provider/path_provider.dart';

Box? my_box; // global var
Future<Box> OpenHiveBox(String box_name) async {
  // initializes hive and opens the box
  if (Hive.isBoxOpen(box_name) == false) {
    // if the box is not opened (not existed)
    Hive.init((await getApplicationDocumentsDirectory()).path); // this is Y we imported path provider
  }
  return await Hive.openBox(box_name);
}

void main() async {
  // whenever u need to invoke a future method before the runApp, you need this line
  //WidgetsFlutterBinding.ensureInitialized();
  //my_box = await OpenHiveBox("My_vocabs_box1");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePageTest(),
    );
  }
}
