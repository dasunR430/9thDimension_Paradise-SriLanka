import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Models/entity_member.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Form/form_screen.dart';

import '../Models/entity.dart';

class ApplicantController extends GetxController {

  final ApplicantEntity _applicantEntity;

  ApplicantController(this._applicantEntity);

  static ApplicantController instance = Get.find();

  ApplicantEntity get applicantEntity => _applicantEntity;

  // Add main applicant
  void addMainApplicant() async{
    _applicantEntity.mainVisaApplicant = await Get.to<VisaApplicant>(FormScreen(true));
    update(); // Update the UI
  }

  // Add other applicant
  void addOtherApplicant() async{
    if (_applicantEntity.mainVisaApplicant == null) {
      Get.snackbar("Main Applicant missing", "Please add the main applicant first.");
      return;
    }
    EntityMember? entityMember = await Get.to<EntityMember>(FormScreen(false));

    if (entityMember != null) {
      _applicantEntity.entityMembers?.add(entityMember);
      update();
    }
  }

  // Remove an applicant
  void removeApplicant(EntityMember entityMember) {
    if (_applicantEntity.entityMembers != null) {
      _applicantEntity.entityMembers!.remove(entityMember);
      update();
    }
  }

}
