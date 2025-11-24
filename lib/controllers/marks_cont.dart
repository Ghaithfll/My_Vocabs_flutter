import 'package:get/get.dart';
import 'package:my_vocabs/main.dart';

class Marks_controller extends GetxController {
  RxList marks = [].obs;

  RxList My_vocabs = [].obs;
  RxList My_vocabs_meanings = [].obs;

  void Read_my_vocabs_lists() {
    /* if u typed my_vocabs = box.get("my_vocabs_list")
    this wwill arise a type error cuz box.get returns List<dynamic>
    */
    My_vocabs.assignAll(my_box!.get("My_vocab_list") ??
        []); // this assigns all the content of the stored list to our rxList, and in case the key is not existed, it assigns an empty list to prevent nulls
    My_vocabs_meanings.assignAll(my_box!.get("My_vocab_meanings_list") ?? []);
    print("\n\n DATA READ SUCCESSFULLY!!! \n");
  }

  void Save_my_vocabs_lists() {
    
    my_box!.put("My_vocab_list", My_vocabs.toList());
    //  .toList  converts the rxlist to a normal List
    my_box!.put("My_vocab_meanings_list", My_vocabs_meanings.toList());
  }

  void Read_test_marks() {
    //  marks.assignAll(my_box!.get("test_marks") ?? []);
  }
  void Save_test_marks() {
    //  my_box!.put("test_marks", marks);
  }
}
