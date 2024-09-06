import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Models/visaType.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';
import 'package:paradise_sri_lanka/Services/API/database.dart';

import '../Models/entity.dart';

class VisaTypeSelectionController extends GetxController {
  RxInt currentPage = 0.obs;
  int _cPage = 0;
  var pages = 5;
  RxDouble progress = 0.0.obs;



  final TextEditingController countryIdController = TextEditingController();
  final TextEditingController travelTypeController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController visaSubCategoryController = TextEditingController();
  final TextEditingController arrivalDateController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController accommodationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();


  List<String> titles = [
    "Let's Start",
    "Just a few more questions",
    "Just a few more questions",
    "Almost there",
    "Last Question"
  ];

  final PageController pageController = PageController(initialPage: 0);

  late List<VisaType> visaTypes;
  List<String> purposes = [
    'Sightseeing / Holidaying',
    'Visiting friends and relatives',
    'Medical treatment including Ayurvedic and Yoga',
    'Participating in sports events, competitions, and activities relating to cultural performance',
  ];

  List<String> entryTypes = [
    'Individual',
    'Group',
  ];

  @override
  void onInit() {
    _getVisaTypes();
    super.onInit();
  }

  void nextPage() {
    if (_cPage < pages-1) {
      if (_validatePage()) {
        _cPage++;
        pageController.animateToPage(_cPage,
            duration: Durations.short3, curve: Curves.linear);
        setIndicator();
      } else {
        Get.snackbar(
          "Incomplete Information",
          "Please fill in all required fields before proceeding.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } else {

      ApplicantEntity entity = ApplicantEntity(
        countryId: countryIdController.text,
        visaTypeId: visaSubCategoryController.text,
        startDate: DateTime.parse(arrivalDateController.text),
      );


    }
  }

  void previousPage() {
    if (_cPage > 0) {
      _cPage--;
      pageController.animateToPage(_cPage,
          duration: Durations.short3, curve: Curves.linear);
      setIndicator();
    }
  }

  void onPageChange(int page) {
    _cPage = page;
    setIndicator();
  }

  void setIndicator() {
    progress.value = (_cPage + 1) / pages;
    currentPage.value = _cPage;
  }

  // Validation method to check if required fields are filled in on each page
  bool _validatePage() {
    switch (_cPage) {
      case 0:
        return countryIdController.text.isNotEmpty; // Page 0 validation: country ID
      case 1:
        return purposeController.text.isNotEmpty; // Page 1 validation: purpose
      case 2:
        return travelTypeController.text.isNotEmpty; // Page 2 validation: travel type
      case 3:
        return visaSubCategoryController.text.isNotEmpty; // Page 3 validation: visa sub-category
      case 4:
        return arrivalDateController.text.isNotEmpty; // Page 4 validation: arrival date
      default:
        return true;
    }
  }

  void _getVisaTypes(){
    ParadiseDataBase.visaTypes.then((value) {
      if(value == null){
        visaTypes = [];
        return;
      }
      visaTypes = value;
    });
  }
}
