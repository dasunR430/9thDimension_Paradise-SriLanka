import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';

class ApplicantController extends GetxController {
  // Observable list of applicants
  var applicants = <VisaApplicant>[].obs;

  // Observable main applicant
  var mainApplicant = Rx<VisaApplicant?>(null);

  // Method to add the main applicant
  void addMainApplicant(VisaApplicant applicant) {
    mainApplicant.value = applicant;
    update(); // Notify listeners
  }

  // Method to add other applicants
  void addOtherApplicant(VisaApplicant applicant) {
    applicants.add(applicant);
    update(); // Notify listeners
  }

  // Method to remove an applicant
  void removeApplicant(VisaApplicant applicant) {
    applicants.remove(applicant);
    update(); // Notify listeners
  }
}
