import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Views/Applicants%20Screen/test_sceen.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Form/form_screen.dart';
import '../Models/visaType.dart';
import '../Services/API/database.dart';
import 'applicants_controller.dart';

class VisaTypeSelectionController extends GetxController {
  final ApplicantController applicantsController =
      Get.find<ApplicantController>();

  RxInt currentPage = 0.obs;
  int _cPage = 0;
  var pages = 5;
  RxDouble progress = 0.0.obs;

  final PageController pageController = PageController();

  final TextEditingController countryIdController = TextEditingController();
  final TextEditingController travelTypeController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController visaSubCategoryController =
      TextEditingController();
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

  @override
  void onClose() {
    // Dispose controllers when not needed
    pageController.dispose();
    countryIdController.dispose();
    travelTypeController.dispose();
    purposeController.dispose();
    visaSubCategoryController.dispose();
    arrivalDateController.dispose();
    departureDateController.dispose();
    accommodationController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (_cPage < pages - 1) {
      if (_validatePage()) {
        _cPage++;
        pageController.animateToPage(_cPage,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
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
    } else if (_cPage == pages - 1) {
      if (_validatePage()) {
        String countryId = countryIdController.text;
        String visaTypeId = visaSubCategoryController.text;
        DateTime? startDate = tryParseDate(arrivalDateController.text);
        String travelType = travelTypeController.text;

        if (startDate == null) {
          Get.snackbar(
            "Invalid Date",
            "Please enter a valid date.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          return;
        }

        applicantsController.setVisaDetails(
          countryId: countryId,
          visaTypeId: visaTypeId,
          startDate: startDate,
        );

        // Navigate based on travel type
        if (travelType != "Individual") {
          Get.off(() => ApplicantsScreen());
        } else {
          Get.off(() => FormScreen("Main","Individual"));
        }
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
    }
  }

  void previousPage() {
    if (_cPage > 0) {
      _cPage--;
      pageController.animateToPage(_cPage,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
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

  // Validation method
  bool _validatePage() {
    switch (_cPage) {
      case 0:
        return countryIdController.text.isNotEmpty;
      case 1:
        return purposeController.text.isNotEmpty;
      case 2:
        return travelTypeController.text.isNotEmpty;
      case 3:
        return visaSubCategoryController.text.isNotEmpty;
      case 4:
        return arrivalDateController.text.isNotEmpty;
      default:
        return true;
    }
  }

  DateTime? tryParseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return null;
    }
  }

  void _getVisaTypes() {
    ParadiseDataBase.visaTypes.then((value) {
      if (value == null) {
        visaTypes = [];
        return;
      }
      visaTypes = value;
    });
  }
}
