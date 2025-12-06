import 'package:get/get.dart';

class All_Voc_Controller extends GetxController {
  RxList<String> Meanings = <String>[].obs;
  RxList<String> Vocabs = <String>[].obs;
  RxBool Delete_Vocabs_Mode = false.obs;

  void Initialize_cont({required List<String> Eng, required List<String> Ar}) {
    if (Eng.length != 0 && Ar.length != 0) {
      Vocabs.assignAll(Eng);
      Meanings.assignAll(Ar);
    }
    update();
    print("Initialized");
  }

  void add_voc({required String eng, required String ar}) {
    Vocabs.add(eng);
    Meanings.add(ar);
  }

  void Enable_Delete_Voc_Mode() {
    Delete_Vocabs_Mode.value = true;
  }
  
  void Disable_Delete_Voc_Mode() {
    Delete_Vocabs_Mode.value = false;
  }
  
}
