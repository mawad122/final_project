import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/data/patients_account_model.dart';
import 'package:final_project/app/modules/home/controllers/login_controller.dart';
import 'package:final_project/app/modules/home/controllers/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'layout_patients_app_controller.dart';

class RegisterPatientsController extends GetxController {
  //TODO: Implement RegisterPatientsController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void register(dynamic email, dynamic password, dynamic name, dynamic phone) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      GetStorage().write("tokenOfPatients",value.user?.uid);
      createAccount(name,email,phone,value.user?.uid,password);
      update();
    })
        .catchError((error) {
      print(error.toString());
    });
    update();

  }

  void createAccount(name, email, phone, uid,password) {
    patientsAccountModel = PatientsAccountModel(name, email, phone, uid,"اكتب سيرتك الذاتية","https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2");
    FirebaseFirestore.instance
        .collection('patients')
        .doc(uid)
        .set(patientsAccountModel?.toMAp()??{})
        .then((value) {
      LoginController loginController = Get.put(LoginController());
      tokenOfPatients=patientsAccountModel?.token;

      print("the token is$tokenOfPatients");

      loginController.moveBetweenPages('LayoutPatientsAppView');
   update();
      print(patientsAccountModel?.name);
    }).catchError((error) {
      print(error.toString());
    });
    update();
  }
}
