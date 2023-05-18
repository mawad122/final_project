import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/data/categories_model.dart';
import 'package:final_project/app/data/doctor_account_model.dart';
import 'package:final_project/app/data/patients_account_model.dart';
import 'package:final_project/app/modules/patients/controllers/article_controller.dart';
import 'package:final_project/app/modules/patients/controllers/group_chat_patients_controller.dart';
import 'package:final_project/app/modules/patients/views/chat_patients_view.dart';
import 'package:final_project/app/modules/patients/views/home_patients_view.dart';
import 'package:final_project/app/modules/patients/views/profile_patients_view.dart';
import 'package:final_project/app/modules/patients/views/subscriptions_view.dart';
import 'package:get/get.dart';

import '../../home/controllers/register_controller.dart';

dynamic tokenOfPatients;
var indexPatients = 0;
class LayoutPatientsAppController extends GetxController {
  //TODO: Implement LayoutPatientsAppController
  List<CategoriesModel> categories = [];
  List<CategoriesModel> subsriptions = [];
  ArticleController articleController=ArticleController();
  GroupChatPatientsController groupChatPatientsController=GroupChatPatientsController();

  Future<void>getAllSubsriptions() async{
  subsriptions=[];
  FirebaseFirestore.instance.collection("Categories").where("like",isEqualTo: true).where("idOfPatients",isEqualTo: tokenOfPatients).get().then((value) {
    value.docs.forEach((element) {
     subsriptions.add(CategoriesModel.fromJson(element.data()));
     print("the subsriptions is${subsriptions.length}");
      update();
    });
  });
}
  Future<void> getAllCategories() async {
    categories=[];
    FirebaseFirestore.instance.collection("Categories").get().then((value){
      value.docs.forEach((element) {
        categories.add(CategoriesModel.fromJson(element.data()));
        update();
      });
    });
  }
  Future<void> updateCategories(id) async {

    FirebaseFirestore.instance.collection("Categories").doc("$id").get().then((value){
      if(value.data()?['like']==true){
        FirebaseFirestore.instance.collection("Categories").doc("$id").update({"like":false,"idOfPatients":tokenOfPatients}).then((value) {
          getAllSubsriptions();
          getAllCategories();

        });
      }
      if(value.data()?['like']==false){
        FirebaseFirestore.instance.collection("Categories").doc("$id").update({"like":true,"idOfPatients":tokenOfPatients}).then((value) {
          getAllSubsriptions();
          getAllCategories();
        });
      }
    });
    update();
  }


  final count = 0.obs;
  List screenPatients=[
    HomePatientsView(),
    ChatPatientsView(),
    SubscriptionsView(),
    ProfilePatientsView(),
  ];
  List titleOfPatientsScreen=[
    'الصفحة الرئيسية',
    'الدردشات',
    'الاشتراكات',
    'الملف الشخصي',
  ];
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

  Future<void> changeValueOfIndex(value) async {
    indexPatients=value;
    if(indexPatients==0){
      // articleController.changevalueOfHomePatients(false);
      // groupChatPatientsController.changevalueOChatPatients(false);
      getAllCategories();
    }
    if(indexPatients==1){
      // articleController.changevalueOfHomePatients(false);
      // groupChatPatientsController.changevalueOChatPatients(false);

      await  getAllAccountDoctors();
      update();

    }
    if(indexPatients==2){
      // articleController.changevalueOfHomePatients(false);
      // groupChatPatientsController.changevalueOChatPatients(false);

      await getAllSubsriptions();
      update();
    }
    if(indexPatients==3){
      // articleController.changevalueOfHomePatients(false);
      // groupChatPatientsController.changevalueOChatPatients(false);

      await getPatientsData();
      update();

    }
    print(indexPatients);
    update();
  }
  List <DoctorAccountModel>doctors=[];
  Future<void> getAllAccountDoctors() async {
    doctors = [];
    FirebaseFirestore.instance.collection("doctors").get().then((value) {
      value.docs.forEach((element) {
        doctors.add(DoctorAccountModel.formJson(element.data()));
          update();

          print(doctors.length);
      });
    });
    update();
  }
  Future<void>getPatientsData()async{
    FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).get().then((value){

      patientsAccountModel=PatientsAccountModel.formJson(value.data()!);
      print("The User is${patientsAccountModel?.name.toString()}");
      update();

    });
  update();
  }
}
